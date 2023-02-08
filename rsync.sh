#!/usr/bin/env bash
#
# From: https://git.samba.org/?p=rsync.git;a=blob_plain;f=support/rsync-no-vanished;hb=HEAD
#
REAL_RSYNC=/usr/bin/rsync
IGNOREEXIT=24
IGNOREOUT='^(file has vanished: |rsync warning: some files vanished before they could be transferred)'

# If someone installs this as "rsync", make sure we don't affect a server run.
for arg in "${@}"; do
    if [[ "$arg" == --server ]]; then
	exec $REAL_RSYNC "${@}"
	exit $? # Not reached
    fi
done

set -o pipefail

# This filters stderr without merging it with stdout:
{ $REAL_RSYNC "${@}" 2>&1 1>&3 3>&- | grep -E -v "$IGNOREOUT"; ret=${PIPESTATUS[0]}; } 3>&1 1>&2

if [[ $ret == $IGNOREEXIT ]]; then
    ret=0
fi

exit $ret
