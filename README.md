# Progress Download
> Simple customisable progress bar for downloading remote files in Ruby.

## Installation
In your shell:
```shell
gem install progress_download
```
or, form source
```shell
git clone https://github.com/Demonstrandum/progress_download.git
cd progress_download/
```
Then install it:
```shell
gem build progress_download.gemspec
gem install progress_download-*
```
or use it directly:
```shell
ruby -Ilib bin/* [OPTIONS] ... [URL]
# or just copy the lib direcotry to where you need it
```

## Usage
You may test it out in your terminal by doing:
```shell
progress-download [STYLE] [URI]
# For example
progress-download --style dots http://ipv4.download.thinkbroadband.com/10MB.zip
```
Output should look something like:
```shell
‘10MB.zip’ — 8.44 / 10.0 MiB at 1.76 MiB/s in 4.78s
⠴ [ █████████████████████████████████████████████▒▒▒▒▒▒▒▒▒ ]  84%
# ... after some time ...
‘10MB.zip’ — 10.00 / 10.0 MiB at 1.85 MiB/s in 5.41s
⠶ [ ██████████████████████████████████████████████████████ ] 100%
```
where the bar fills the entier width of the terminal.
### In Ruby
For example:
```ruby
require 'progress_download'
# Basic usage
url = 'http://ipv4.download.thinkbroadband.com/10MB.zip'
ProgressDownload.download url
# More advanced options include:
ProgressDownload.download url, :location => '~/Downloads', :spinner => :classic, :speed => 0.1, :refresh => 0.5
```
 By default:
 - `:location` is the current working directory (`Dir.getwd`)
 - `:spinner` is `:dots`
 - `:speed` is `1`
 and
 - `:refresh` is `0.125`

`:refresh` is the amount of time between each 'frame' in seconds, by this, `:speed` is how many times the spinner updates per frame drawn, meaning thusly that `:speed` must be 1 or less, 1 meaning that the spinner advances one step for every 'frame' drawn, and 0.5 would be every second frame, etc.

Some of the default available spinner styles:
```ruby
%w{ - \\ | / Done! }       # `:classic` - Traditional line spinner.
%w{ /^v^\\ \\^v^/ \\ovo/ } # `:bats`    - Happy bats, old DOS spinner.
%w{ ⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈ · } # `:tracer`  - Rectangle trace.
%w{ ← ↖ ↑ ↗ → ↘ ↓ ↙ ↔ }  # `:arrows`  - Spinning arrows.
%w{ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▇ ▆ ▅ ▄ ▃ ▁ █ } # `:pump`    - Grow, shrink.
%w{ ▉ ▊ ▋ ▌ ▍ ▎ ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▉ }   # `:breathe` - Thin and fat.
%w{ ┤ ┘ ┴ └ ├ ┌ ┬ ┐ ✓ }    # `:fold`   - Folding lines.
%w{ ⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷ ⣿ } # `:sorter` - Braille arranger.
%w{ ⠖ ⠲ ⠴ ⠦ ⠶ }           # `:dots`   - Braille spinner.
```

## Custom Spinners
You can add your own spinner by simply doing:
```ruby
require 'progress_download'

ProgressDownload.add_spinner :balloon, %w{ . o O @ * Done! }  # For example
# then just specify it when downloading a file:
my_url = 'http://ipv4.download.thinkbroadband.com/512MB.zip'
ProgressDownload.download my_url, :spinner => :balloon
```
which would look something like:
```shell
                                                                 #| Terminal Width
‘512MB.zip’ —  23.83 / 511.79 MiB at 2.20 MiB/s in 10.82s        #|
O [ ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ]   4%    #|
# ... after some time ...                                        #|
‘512MB.zip’ — 511.79 / 511.79 MiB at 7.52 MiB/s in 68.07s        #|
Done! [ ██████████████████████████████████████████████████ ] 100%#|
                                                                 #|
```
