Forked from eea.docker.rsync to add error checking. 

The rsync.sh script simply wraps the original command to catch the vanishing file warning.

# Simple rsync container based on alpine

A simple rsync server/client Docker image to easily rsync data within Docker volumes

## Simple Usage

Get files from remote server within a `docker volume`:

    $ docker run --rm -v blobstorage:/data/ bgercken/eeacms-rsync-with-script:latest \
             rsync.sh -avzx --numeric-ids user@remote.server.domain.or.ip:/var/local/blobs/ /data/

Get files from `remote server` to a `data container`:

    $ docker run -d --name data -v /data busybox
    $ docker run --rm --volumes-from=data  bgercken/eeacms-rsync-with-script:latest \
             rsync.sh -avz user@remote.server.domain.or.ip:/var/local/blobs/ /data/


