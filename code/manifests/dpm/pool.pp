define dmlite::dpm::pool(
  $pool_type    = 'filesystem',
  $def_filesize = '100M'
) {

  Class[dmlite::shell::install] -> Dmlite::Dpm::Pool <| |>

  exec{'lcgdm_dpm_pool-${name}':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"pooladd ${name} ${pool_type}\"",
    unless  => "dmlite-shell -e \"poolinfo\" | grep \"^${name}\""
  }

}
