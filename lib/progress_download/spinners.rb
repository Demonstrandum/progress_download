module ProgressDownload
  @@custom_spinners = Hash.new

  def self.spinner_hash
    types = %w{ classic bats tracer arrows pump breathe fold sorter dots }.map(&:to_sym)
    types.push *@@custom_spinners.keys

    flat = Array.new
    flat << %w{ - \\ | / Done! }       # `:classic` - Traditional line spinner.
    flat << %w{ /^v^\\ \\^v^/ \\ovo/ } # `:bats`    - Happy bats, old DOS spinner.
    flat << %w{ ⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈ · } # `:tracer`  - Rectangle trace.
    flat << %w{ ← ↖ ↑ ↗ → ↘ ↓ ↙ ↔ }  # `:arrows`  - Spinning arrows.
    flat << %w{ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▇ ▆ ▅ ▄ ▃ ▁ █ } # `:pump`    - Grow, shrink.
    flat << %w{ ▉ ▊ ▋ ▌ ▍ ▎ ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▉ }   # `:breathe` - Thin and fat.
    flat << %w{ ┤ ┘ ┴ └ ├ ┌ ┬ ┐ ✓ }    # `:fold`   - Folding lines.
    flat << %w{ ⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷ ⣿ } # `:sorter` - Braille arranger.
    flat << %w{ ⠖ ⠲ ⠴ ⠦ ⠶ }           # `:dots`   - Braille spinner.

    spinners = Hash.new
    types.each.with_index { |type, i| spinners[type] = flat[i] }
    spinners
  end

  SPINNERS = spinner_hash

  def self.add_spinner name, states
    @@custom_spinners[name.to_sym] = states
    SPINNERS.replace spinner_hash
  end
end
