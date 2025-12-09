# hotcore

Displays the highest CPU core utilization percentage. Useful for identifying CPU bottlenecks while gaming with MangoHUD overlay. Tested on Bazzite.

## Installation

### Homebrew (Recommended)

```bash
brew tap tbarker/hotcore
brew install hotcore
```

Or in one command:
```bash
brew install tbarker/hotcore/hotcore
```

### Manual Installation

Clone this repository:
```bash
git clone https://github.com/tbarker/hotcore.git
cd hotcore
```

## Usage

Test the script:
```bash
hotcore
# Or if installed manually:
./hotcore
```

## Steam Launch Options (MangoHUD Integration)

### Option 1: Use config file

Add to a game's Steam launch options:

```
MANGOHUD=1 MANGOHUD_CONFIG=/path/to/your/mangohud.conf %command%
```

Your MangoHUD config file should include:

```
legacy_layout=0              # required for exec to work
font_size_secondary=24       # optional, makes labels consistent size
custom_text=CPU MAX          # label for the metric
exec=hotcore                 # if installed via Homebrew
# OR for manual installation:
# exec=/path/to/hotcore/hotcore
```

### Option 2: Pass parameters directly

If you installed via Homebrew:
```
MANGOHUD=1 MANGOHUD_CONFIG="legacy_layout=0,font_size_secondary=24,custom_text=CPU MAX,exec=hotcore" %command%
```

If you installed manually:
```
MANGOHUD=1 MANGOHUD_CONFIG="legacy_layout=0,font_size_secondary=24,custom_text=CPU MAX,exec=/path/to/hotcore/hotcore" %command%
```

## License

MIT License

