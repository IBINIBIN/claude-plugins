#!/bin/bash
ACTION="${1:-}"

play_sound() {
    if [ "$(uname -s)" = "Darwin" ]; then
        afplay "$1"
    else
        powershell.exe -c "[System.Media.SystemSounds]::$2.Play()" &>/dev/null
    fi
}

case "$ACTION" in
    beep_end)
        play_sound "/System/Library/Sounds/Glass.aiff" "Exclamation"
        ;;
    beep_select)
        play_sound "/System/Library/Sounds/Blow.aiff" "Hand"
        ;;
    *)
        echo "$(date '+%H:%M:%S') [$$] ERROR: unknown action '$ACTION'" >> "$LOG_FILE"
        exit 1
        ;;
esac
