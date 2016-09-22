define dmlite::dpm::filesystem(
  $ensure = present,
  $headnode = $dmlite::dpm::config::headnode,
  $server = $fqdn,
  $pool = '',
  $fs = '',
) {

    Class[dmlite::shell::install] -> Dmlite::Dpm::Filesystem <| |>

    ensure_packages(['dpm-python'])

    if $ensure == 'present' {
      $cmd = 'fsadd'
      $grep = 'grep -q'
      $options = "${fs} ${pool} ${server}"
    } else {
      $cmd = 'fsdel'
      $grep = '! grep -q'
      $options = "${fs} ${server}"
    }

    exec{"${pool}/${server}:${fs}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      command => "dmlite-shell -e \"${cmd} ${options}\"",
      unless  => "dmlite-shell -e \"qryconf\" | ( ${grep} \"${server} ${fs}\" )", # subshell required to invert return status with !
      require => Ensure_packages['dpm-python']
    }

}

