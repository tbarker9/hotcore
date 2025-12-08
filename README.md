# mangohud-config

Displays the highest CPU core utilization percentage in MangoHUD overlay. Useful for identifying CPU bottlenecks while gaming.

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

Replace `/path/to/mangohud-config` with your actual repo path.

### Option 2: Pass exec parameters directly

```
MANGOHUD=1 MANGOHUD_CONFIG="legacy_layout=0,font_size_secondary=24,custom_text=CPU MAX,exec=/path/to/mangohud-config/scripts/max_cpu_core.sh" %command%
```

This bypasses the config file and sets the exec parameters at launch time.

**Note:**
- The `legacy_layout=0` parameter is required for the `exec` functionality to work properly.
- You'll need to set `font_size_secondary` if you want `custom_text` or `exec` output to match `font_size` (`font_size` is set to 24 by default, custom labels and metrics are set to .55 * `font_size` for some reason).

## License

MIT License
