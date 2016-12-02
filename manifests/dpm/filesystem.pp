define dmlite::dpm::filesystem(
  $ensure = present,
  $server = $fqdn,
  $pool = '',
  $fs = '',
) {

    Class[dmlite::shell::install] -> Dmlite::Dpm::Filesystem <| |>

    if $ensure == 'present' {
      $cmd = 'fsadd'
      $grep = 'grep -q'
      $options = "${pool}"
    } else {
      $cmd = 'fsdel'
      $grep = '! grep -q'
      $options = ''
    }

    exec{"${pool}/${server}:${fs}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      command => "dmlite-shell -e \"${cmd} ${fs} ${pool_option} ${server}\"",
      unless  => "dmlite-shell -e \"qryconf\" | ( ${grep} \"${server} ${fs}\" )", # subshell required to invert return status with !
    }

}

