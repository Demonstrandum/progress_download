require_relative 'lib/progress_download'

Gem::Specification.new do |s|
  s.name        = 'progress_download'
  s.version     = ProgressDownload::version
  s.required_ruby_version = '>= 2.0.0'
  s.executables << 'progress-download'
  s.date        = Time.now.to_s.split(/\s/)[0]
  s.summary     = "Downloading progress bar in Ruby."
  s.description = "Simple customisable progress bar for downloading in Ruby."
  s.authors     = ["Demonstrandum"]
  s.email       = 'knutsen@jetspace.co'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w{ LICENSE README.md }
  s.require_path= 'lib'
  s.homepage    = 'https://github.com/Demonstrandum/progress_bar'
  s.license     = 'GPL-2.0'
end
