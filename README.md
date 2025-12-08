# mangohud-config

Displays the highest CPU core utilization percentage in MangoHUD overlay. Useful for identifying CPU bottlenecks while gaming. Tested on Bazzite

## Usage

Test the script:
```bash
./scripts/max_cpu_core.sh
```

## Steam Launch Options

### Option 1: Use config file

Add to a game's Steam launch options:

```
MANGOHUD=1 MANGOHUD_CONFIG=/path/to/mangohud-config/config %command%
```

Replace `/path/to/mangohud-config` with your actual Mangohud config path.

Config should have four extra params, a custom label and the path to this script

```
legacy_layout=0 # required for exec to work
font_size_secondary=24  # optional, but makes the custom label and exec output the same size as other params 
custom_text=CPU MAX # custom label
exec=/path/to/mangohud-config/scripts/max_cpu_core.sh # path to script in this repo
```

### Option 2: Pass exec parameters directly

```
MANGOHUD=1 MANGOHUD_CONFIG="legacy_layout=0,font_size_secondary=24,custom_text=CPU MAX,exec=/path/to/mangohud-config/scripts/max_cpu_core.sh" %command%
```

This bypasses the config file and sets the exec parameters at launch time.

## License

MIT License

