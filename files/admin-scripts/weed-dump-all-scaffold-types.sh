#!/usr/bin/env bash
## weed-dump-all-scaffold-types.sh
## Dump all config types.
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2024-07-28
## MODIFIED: 2025-08-18
## ======================================== ##
echo "[${0##*/}] Script starting (at $(date -Is))" >&2

config_types=(
	filer
	notification
	replication
	security
	master
	)
for config_type in "${config_types[@]}"; do
	echo "config_type=${config_type@Q}" >&2
	weed scaffold -config="${config_type?}" > "${config_type?}.toml"
done


echo "[${0##*/}] Script finished (at $(date -Is))" >&2
exit
