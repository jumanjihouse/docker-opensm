#!/bin/sh

# Load kernel modules.
/usr/libexec/rdma-init-kernel

touch "${OSM_TMP_DIR}/opensm-subnet.lst"
tail -F "${OSM_TMP_DIR}/opensm-subnet.lst" &

exec /usr/sbin/opensm -F /etc/rdma/opensm.conf -f stdout "$@"
