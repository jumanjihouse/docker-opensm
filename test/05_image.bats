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

@test "userspace ib driver \"infinipath-psm\" is installed" {
  run docker run --entrypoint rpm opensm -q infinipath-psm
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libcxgb3\" is installed" {
  run docker run --entrypoint rpm opensm -q libcxgb3
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libcxgb4\" is installed" {
  run docker run --entrypoint rpm opensm -q libcxgb4
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libipathverbs\" is installed" {
  run docker run --entrypoint rpm opensm -q libipathverbs
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libmthca\" is installed" {
  run docker run --entrypoint rpm opensm -q libmthca
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libmlx4\" is installed" {
  run docker run --entrypoint rpm opensm -q libmlx4
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libmlx5\" is installed" {
  run docker run --entrypoint rpm opensm -q libmlx5
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libnes\" is installed" {
  run docker run --entrypoint rpm opensm -q libnes
  [ ${status} -eq 0 ]
}

@test "userspace ib driver \"libocrdma\" is installed" {
  run docker run --entrypoint rpm opensm -q libocrdma
  [ ${status} -eq 0 ]
}

@test "connection mgmt library \"librdmacm\" is installed" {
  run docker run --entrypoint rpm opensm -q librdmacm
  [ ${status} -eq 0 ]
}

@test "connection mgmt library \"librdmacm-utils\" is installed" {
  run docker run --entrypoint rpm opensm -q librdmacm-utils
  [ ${status} -eq 0 ]
}

@test "connection mgmt library \"ibacm\" is installed" {
  run docker run --entrypoint rpm opensm -q ibacm
  [ ${status} -eq 0 ]
}

@test "\"libibverbs\" is installed" {
  run docker run --entrypoint rpm opensm -q libibverbs
  [ ${status} -eq 0 ]
}

@test "\"libibverbs-utils\" is installed" {
  run docker run --entrypoint rpm opensm -q libibverbs-utils
  [ ${status} -eq 0 ]
}

@test "\"ibv_devinfo\" is in path" {
  run docker run --entrypoint bash opensm command -v ibv_devinfo
  [ ${status} -eq 0 ]
}

@test "\"libibcommon\" is installed" {
  run docker run --entrypoint rpm opensm -q libibcommon
  [ ${status} -eq 0 ]
}

@test "\"dapl\" is installed" {
  run docker run --entrypoint rpm opensm -q dapl
  [ ${status} -eq 0 ]
}

@test "\"compat-dapl\" is installed" {
  run docker run --entrypoint rpm opensm -q compat-dapl
  [ ${status} -eq 0 ]
}

@test "\"dapl-utils\" is installed" {
  run docker run --entrypoint rpm opensm -q dapl-utils
  [ ${status} -eq 0 ]
}

@test "\"compat-dapl-utils\" is installed" {
  run docker run --entrypoint rpm opensm -q compat-dapl-utils
  [ ${status} -eq 0 ]
}

@test "\"mstflint\" is installed" {
  run docker run --entrypoint rpm opensm -q mstflint
  [ ${status} -eq 0 ]
}
