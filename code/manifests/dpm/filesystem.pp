define dmlite::dpm::filesystem(
  $ensure = present,
  $headnode = $dmlite::dpm::config::headnode,
  $server = $fqdn,
  $pool,
  $fs
) {

    Class[Dmlite::Shell::Install] -> Dmlite::Dpm::Filesystem <| |>

    if $ensure == "present" {
      $cmd = "dpm-addfs"
      $grep = "grep -q"
      $pool_option = "--poolname ${pool}"
    } else {
      $cmd = "dpm-rmfs"
      $grep = "! grep -q"
      $pool_option = "" # dpm-rmfs does not need/accept --poolname
    }

    exec{"$pool/$server:$fs":
      path     => "/bin:/sbin:/usr/bin:/usr/sbin",
      command  => "dmlite-shell -e \"ls\""
      #command => "dmlite-shell -e \"\"",
      #unless  => "dmlite-shell -e \"\" | ( ${grep} \"$server $fs\" )" # subshell required to invert return status with !
    }

}

