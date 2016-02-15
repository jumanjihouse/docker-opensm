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
  # circleci collects output.
  delete="WARNING: Your kernel does not support memory swappiness capabilities, memory swappiness discarded."
  lines=(${lines[@]/$delete})
  [[ ${#lines[@]} -eq 0 ]]
}

@test "image contains ibutils package" {
  run docker run --entrypoint rpm opensm -q ibutils
  [ ${status} -eq 0 ]
}

@test "ibdiagnet is in path" {
  run docker run --entrypoint bash opensm command -v ibdiagnet
  [ ${status} -eq 0 ]
}

@test "image contains qperf package" {
  run docker run --entrypoint rpm opensm -q qperf
  [ ${status} -eq 0 ]
}

@test "qperf is in path" {
  run docker run --entrypoint bash opensm command -v qperf
  [ ${status} -eq 0 ]
}
