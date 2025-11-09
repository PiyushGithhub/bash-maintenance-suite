# Bash Maintenance Suite 🛠️ (Assignment 5: LinuxOS & LSP)

A complete, menu-driven suite of Bash scripts to automate system maintenance tasks: backups, system updates/cleanup, and log monitoring. Built with robust error handling, logging, and simple configuration.

## Features

- **Automated backups** using `tar` (with optional `rsync`) to a timestamped archive.
- **Retention policy** to prune old backups (configurable).
- **System updates & cleanup** with automatic package-manager detection (`apt`, `dnf`, `pacman`, `zypper`, `apk`).
- **Log monitoring** for error patterns using `journalctl` or classic `/var/log` files.
- **Central logging** to `logs/` and exit codes suitable for cron/systemd.
- **Menu UI** (`suite.sh`) to run everything interactively.
- **Config file** (`config.env`) to tailor paths, schedules, and behavior.
- **ShellCheck-ready** and unit-ish tests with `bats`-style sh tests (no external deps required).

## Quick Start

```bash
git clone https://github.com/your-username/bash-maintenance-suite.git
cd bash-maintenance-suite
./install.sh
./suite.sh
```

> For non-interactive / cron use, call scripts directly under `scripts/`.

## Project Structure

```
bash-maintenance-suite/
├── config.env
├── install.sh
├── suite.sh
├── scripts/
│   ├── backup.sh
│   ├── update_cleanup.sh
│   ├── log_monitor.sh
│   └── utils.sh
├── tests/
│   ├── test_backup.sh
│   └── test_utils.sh
├── logs/
│   └── .gitkeep
├── crontab.example
├── .github/workflows/shellcheck.yml
├── LICENSE
└── README.md
```

## Configuration

Edit `config.env`:

- `BACKUP_SOURCE_DIRS`: space-separated list of folders to back up.
- `BACKUP_DEST_DIR`: destination folder for backup archives (default `~/backups`).
- `BACKUP_RETENTION_DAYS`: how many days of backups to keep.
- `NON_INTERACTIVE`: `true` to always auto-confirm operations (recommended for cron).
- `LOG_MONITOR_PATTERNS`: regex patterns (| separated) to alert on.
- `LOG_MONITOR_SINCE_MINUTES`: time window to scan logs (journalctl) or tail from files.
- `LOG_MONITOR_FILES`: optional list of files to scan when `journalctl` not available.
- `ALERT_METHOD`: `log`, `notify`, or `mail` (requires `mail`/`mailx` configured).

## Example Cron Setup

```
# m h dom mon dow command
# Daily backup at 02:30
30 2 * * * /path/to/bash-maintenance-suite/scripts/backup.sh >> /path/to/bash-maintenance-suite/logs/cron.log 2>&1
# Daily update & cleanup at 03:15
15 3 * * * /path/to/bash-maintenance-suite/scripts/update_cleanup.sh >> /path/to/bash-maintenance-suite/logs/cron.log 2>&1
# Every 30 min log scan
*/30 * * * * /path/to/bash-maintenance-suite/scripts/log_monitor.sh --scan >> /path/to/bash-maintenance-suite/logs/cron.log 2>&1
```

## Tests

Run simple tests (no external framework needed):

```bash
bash tests/test_utils.sh
bash tests/test_backup.sh
```

## License

MIT — see `LICENSE`.
