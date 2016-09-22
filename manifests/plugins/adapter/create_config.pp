define dmlite::plugins::adapter::create_config (
  $config_dir_name    = 'dmlite',
  $dpmhost            = $dmlite::plugins::adapter::params::dpmhost,
  $nshost             = $dmlite::plugins::adapter::params::nshost,
  $connection_timeout = $dmlite::plugins::adapter::params::connection_timeout,
  $connection_poolsize = $dmlite::plugins::adapter::params::connection_poolsize,
  $retry_limit        = $dmlite::plugins::adapter::params::retry_limit,
  $retry_interval     = $dmlite::plugins::adapter::params::retry_interval,
  $enable_dpm         = $dmlite::plugins::adapter::params::enable_dpm,
  $enable_io          = $dmlite::plugins::adapter::params::enable_io,
  $enable_rfio        = $dmlite::plugins::adapter::params::enable_rfio,
  $enable_ns          = $dmlite::plugins::adapter::params::enable_ns,
  $enable_pooldriver  = $dmlite::plugins::adapter::params::enable_pooldriver,

  $token_password     = '',
  $token_id           = $dmlite::plugins::adapter::params::token_id,
  $token_life         = $dmlite::plugins::adapter::params::token_life,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group,
  $adminuser          = undef
) {
  Class[dmlite::params] -> Dmlite::Plugins::Adapter::Create_config <| |>

  $libdir = $dmlite::params::libdir

  if defined (Class[xrootd::service]){
    Dmlite::Plugins::Adapter::Create_config <| |> ~> Class[xrootd::service]
  }
  if defined (Class[dmlite::dav::service]){
    Dmlite::Plugins::Adapter::Create_config <| |> ~> Class[dmlite::dav::service]
  }
  if defined (Class[gridftp::service]){
    Dmlite::Plugins::Adapter::Create_config <| |> ~> Class[gridftp::service]
  }
    file {
      "/etc/${config_dir_name}.conf.d/adapter.conf":
      owner   => $user,
      group   => $group,
      mode    => '0600',
      content => template('dmlite/plugins/adapter.conf.erb'),
      require => [Package['dmlite-plugins-adapter'], File["/etc/${config_dir_name}.conf.d"]]
    }
}
