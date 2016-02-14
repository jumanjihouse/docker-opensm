@test "sminfo poll interval is 5 seconds" {
  run docker run opensm --once
  [[ ${output} =~ 'sminfo_polling_timeout = 5000' ]]
}
