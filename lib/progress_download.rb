Dir["#{File.dirname __FILE__}/progress_download/*.rb"].each { |f| require f }

module ProgressDownload
  VERSIONS = { :major => 0, :minor => 1, :tiny => 1 }.freeze

  def self.version *args
    VERSIONS.flatten.select.with_index { |_, i| i.odd? }.join '.'
  end
end
