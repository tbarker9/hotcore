#!/usr/bin/env bash
# max_cpu_core.sh - Display highest CPU core utilization percentage
# Designed for MangoHUD integration on Bazzite Linux
# Shows the maximum utilization across all CPU cores to identify bottlenecks
#
# Uses cached previous reading for efficiency - relies on MangoHUD calling this
# repeatedly (typically every 100-500ms) to provide the sample interval

set -euo pipefail

readonly PROC_STAT="/proc/stat"
readonly CACHE_DIR="${XDG_RUNTIME_DIR:-.}/.max_cpu_cache"
readonly CACHE_FILE="$CACHE_DIR/cpu_stats"

# Read current CPU stats from /proc/stat
# Outputs: "cpu0:total:active cpu1:total:active ..."
read_current_stats() {
    local stats=""

    while IFS=' ' read -r cpu user nice system idle iowait irq softirq steal guest guest_nice; do
        # Skip if not a numbered CPU core
        [[ $cpu =~ ^cpu[0-9]+$ ]] || continue

        # Calculate total and active times
        # Total = sum of all fields
        # Active = total - idle - iowait (we want actual CPU work, not I/O wait)
        local total=$((user + nice + system + idle + iowait + irq + softirq + steal))
        local active=$((user + nice + system + irq + softirq + steal))

        stats="${stats}${cpu}:${total}:${active} "
    done < "$PROC_STAT"

    echo "$stats"
}

# Parse stats string and calculate utilization
# Args: previous_stats current_stats
calculate_max_utilization() {
    local prev_stats=$1
    local curr_stats=$2
    local max=0

    # Parse each core's stats
    for curr_core_data in $curr_stats; do
        local core_name=${curr_core_data%%:*}
        local curr_total=${curr_core_data#*:}
        local curr_total=${curr_total%%:*}
        local curr_active=${curr_core_data##*:}

        # Find matching core in previous stats
        local prev_core_data=""
        for prev in $prev_stats; do
            if [[ "${prev%%:*}" == "$core_name" ]]; then
                prev_core_data=$prev
                break
            fi
        done

        # If we have a previous reading, calculate utilization
        if [[ -n "$prev_core_data" ]]; then
            local prev_total=${prev_core_data#*:}
            local prev_total=${prev_total%%:*}
            local prev_active=${prev_core_data##*:}

            local delta_total=$((curr_total - prev_total))
            local delta_active=$((curr_active - prev_active))

            if (( delta_total > 0 )); then
                local util=$(( (delta_active * 100) / delta_total ))
                if (( util > max )); then
                    max=$util
                fi
            fi
        fi
    done

    echo "$max"
}

# Main execution
main() {
    # Error handling
    if [[ ! -r "$PROC_STAT" ]]; then
        printf "0%%\n"
        return 1
    fi

    # Create cache directory
    mkdir -p "$CACHE_DIR" 2>/dev/null || true

    # Read current stats
    local current_stats=$(read_current_stats)

    # Check if we have cached previous stats
    if [[ -f "$CACHE_FILE" ]]; then
        local previous_stats=$(cat "$CACHE_FILE" 2>/dev/null || echo "")
        if [[ -n "$previous_stats" ]]; then
            # Calculate and output utilization from deltas
            local max=$(calculate_max_utilization "$previous_stats" "$current_stats")
            printf "%d%%\n" "$max"
        else
            # No valid cached data yet
            printf "0%%\n"
        fi
    else
        # First run - no previous data
        printf "0%%\n"
    fi

    # Cache current stats for next invocation
    echo "$current_stats" > "$CACHE_FILE" 2>/dev/null || true
}

main
