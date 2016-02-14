@test "image exists" {
  run docker images
  [[ ${output} =~ opensm ]]
}

@test "image contains opensm package" {
  run docker run --entrypoint rpm opensm -q opensm
  [ ${status} -eq 0 ]
}

@test "RDMA config allows IPoIB" {
  run docker run --entrypoint cat opensm /etc/rdma/rdma.conf
  [[ ${output} =~ 'IPOIB_LOAD=yes' ]]
}

@test "RDMA config does not load iSCSI over RDMA" {
  run docker run --entrypoint cat opensm /etc/rdma/rdma.conf
  [[ ${output} =~ 'ISERT_LOAD=no' ]]
}
