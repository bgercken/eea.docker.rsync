#!/bin/sh
#
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

 ${REAL_RSYNC} "${@}"

exit 0
