require 'progress_download'

ProgressDownload.add_spinner :balloon, %w{ . o O @ * done! }  # For example
# then just specify it when downloading a file:
my_url = 'http://ipv4.download.thinkbroadband.com/512MB.zip'
ProgressDownload.download my_url, :spinner => :balloon
