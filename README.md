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
MANGOHUD=1 MANGOHUD_CONFIG="exec=/path/to/mangohud-config/scripts/max_cpu_core.sh,exec_name=CPU_MAX" %command%
```

This bypasses the config file and sets the exec parameters at launch time.

## License

MIT License
