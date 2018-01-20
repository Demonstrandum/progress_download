require 'net/http'
require 'uri'

module ProgressDownload
  MiB = 1.049e+6

  def self.download address, location: Dir.getwd, spinner: :dots, speed: 1, refresh: 0.125
    uri = URI.parse address
    download_location = "#{File.expand_path location}/#{File.basename uri.path}"
    spin_states = SPINNERS[spinner.to_sym]

    Net::HTTP.start uri.host, uri.port do |http|
      request = Net::HTTP::Get.new uri.request_uri

      http.request request do |response|
        size = response['Content-Length'].to_i

        done = state = 0
        bar_offset = 10 + spin_states.max_by(&:size).size
          # There are 10 extra chars next to the progress bar,
          #   adding on the widest spinner element in bar_offset

        start = Time.now.to_f
        open download_location, 'w' do |io|
          show_progress = Proc.new do |frequency, preset=nil|
            Thread.new do
              loop do
                thread = Thread.current

                done = if preset.nil?
                  thread[:done]
                else
                  preset
                end

                bar_length = %x{ tput cols }.to_i - bar_offset
                percentage = 100 * done / size
                bar_ratio  = bar_length * done / size

                print "\r"
                stats = "‘#{File.basename uri.path}’ — " + ('%.2f' % (done / MiB)).rjust((size / MiB).round(2).to_s.size, ' ') +
                ' / ' + (size / MiB).round(2).to_s + ' MiB' +
                ' at ' + ('%.2f MiB/s' % ((done / MiB) / (Time.now.to_f - start)).round(2)) +
                ' in %.2fs' % (Time.now.to_f - start)

                short_stats = stats.slice 0..(bar_length + bar_offset - 4)
                print short_stats, stats.size == short_stats.size ? '' : '...', "\n"
                # 3 dots and -1 for index correction
                print "\r#{percentage == 100 ? spin_states[-1] : spin_states[state.to_i]} [ #{'█' * bar_ratio}#{'▒' * (bar_length - bar_ratio)} ] #{percentage.to_s.rjust 3, ' '}%"
                print "\033[F"

                state += speed
                state = 0 if state >= spin_states.size - 1
                Thread.stop if percentage == 100
                sleep frequency
              end
            end
          end

          done = 0
          thread = nil
          first_response = true
          response.read_body do |chunk|
            io.write chunk

            if first_response
              thread = show_progress.call refresh
            end

            done += chunk.size
            thread[:done] = done unless thread.nil?
            first_response = false
          end

          thread = show_progress.call 0, preset=size
          # Make sure the progress bar finishes
        end
      end
    end
    sleep 0.3
    print "\n\n"
  end
end
