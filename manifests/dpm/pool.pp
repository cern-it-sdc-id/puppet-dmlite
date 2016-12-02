define dmlite::dpm::pool(
  $pool_type    = 'filesystem',
  $stype        = 'P',
  $def_filesize = '100M'
) {

  Class[dmlite::shell::install] -> Dmlite::Dpm::Pool <| |>

  exec{"lcgdm_dpm_pool-${name}":
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"pooladd ${name} ${pool_type} ${stype}\"",
    unless  => "dmlite-shell -e \"qryconf | grep 'POOL ${name}'\"",
  }

}
