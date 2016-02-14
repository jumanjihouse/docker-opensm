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

@test "image contains infiniband-diags package" {
  run docker run --entrypoint rpm opensm -q infiniband-diags
  [ ${status} -eq 0 ]
}

@test "image does not contain doc files" {
  run docker run --entrypoint find opensm /usr/share/man/ -type f
  [[ ${#lines[@]} ]]
}
