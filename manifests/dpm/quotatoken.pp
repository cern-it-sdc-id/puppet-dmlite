define dmlite::dpm::quotatoken (
  $ensure = present,
  $path = $name,
  $pool = undef,
  $desc = undef,
  $size = undef,
  $groups = [],
) {

    Class[dmlite::shell] -> Dmlite::Dpm::Quotatoken <| |>

    $_groups = join( $groups, ',')

    if $ensure == 'present' {
      $cmd = 'quotatokenset'
      $grep = 'grep -qw'
      $options = "${path} pool ${pool} size ${size} desc '${desc}' groups ${_groups}"
    } else {
      $cmd = 'quotatokendel'
      $grep = '! grep -qw'
      $options = "${path} ${pool}"
    }

    exec{"${pool}/${path}:${size}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      command => "dmlite-shell -e \"${cmd} ${options} \"",
      unless  => "dmlite-shell -e \"quotatokenget / -s\" | ( ${grep} \"${path}\" )", # subshell required to invert return status with !
    }

}
