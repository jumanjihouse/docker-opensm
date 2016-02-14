@test "image exists" {
  run docker images
  [[ ${output} =~ opensm ]]
}

@test "image contains opensm package" {
  run docker run --entrypoint rpm opensm -q opensm
  [ ${status} -eq 0 ]
}
