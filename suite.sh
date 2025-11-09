#!/usr/bin/env bash
set -Eeuo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

# shellcheck source=./scripts/utils.sh
source "./scripts/utils.sh"
# shellcheck source=/dev/null
source "./config.env"

title "Bash Maintenance Suite"
echo
echo "Select an option:"
PS3="Enter choice (1-8): "
options=(
  "Run Backup Now"
  "Run System Update & Cleanup"
  "Log Monitor (scan once)"
  "Log Monitor (follow live)"
  "View Suite Logs"
  "Edit Configuration (config.env)"
  "Help"
  "Exit"
)
select opt in "${options[@]}"; do
  case "$REPLY" in
    1) run_with_log "Backup" "./scripts/backup.sh" ;;
    2) run_with_log "Update & Cleanup" "./scripts/update_cleanup.sh" ;;
    3) run_with_log "Log Monitor (scan once)" "./scripts/log_monitor.sh" --scan ;;
    4) run_with_log "Log Monitor (follow live)" "./scripts/log_monitor.sh" --follow ;;
    5) less +G "./logs/suite.log" || true ;;
    6) ${EDITOR:-nano} "./config.env" ;;
    7) cat <<'EOF'
--- Help ---
This suite provides:
  1) Backups: Creates timestamped tar.gz archives of configured directories.
  2) Updates: Detects your package manager and updates/cleans safely.
  3) Log Monitoring: Scans recent logs for error patterns or follows live.
Use config.env to customize behavior. For automation, use crontab.example.
EOF
       ;;
    8) echo "Bye!"; exit 0 ;;
    *) echo "Invalid option" ;;
  esac
done
