define dmlite::plugins::adapter::create_config (
  $config_dir_name    = 'dmlite',
  $dpmhost            = $dmlite::plugins::adapter::params::dpmhost,
  $nshost             = $dmlite::plugins::adapter::params::nshost,
  $connection_timeout = $dmlite::plugins::adapter::params::connection_timeout,
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
  Class[Dmlite::Params] -> Dmlite::Plugins::Adapter::Create_config <| |>

  $libdir = $dmlite::params::libdir

  if defined (Class[Xrootd::Service]){
    Dmlite::Plugins::Adapter::Create_config <| |> ~> Class[Xrootd::Service]
  }
  if defined (Class[Dmlite::Dav::Service]){
    Dmlite::Plugins::Adapter::Create_config <| |> ~> Class[Dmlite::Dav::Service]
  }
  if defined (Class[Gridftp::Service]){
    Dmlite::Plugins::Adapter::Create_config <| |> ~> Class[Gridftp::Service]
  }
  if $::domain == "cern.ch" {
        teigi::secret::sub_file{"/etc/${config_dir_name}.conf.d/adapter.conf":
          teigi_keys => ['token_password'],
	  owner   => $user,
          group   => $group,
          mode    => '0600',
          template => "dmlite/plugins/adapter.conf.CERN.erb",
          require => [Package['dmlite-plugins-adapter'], File["/etc/${config_dir_name}.conf.d"]]
        }
  }
  else {
    file {
      "/etc/${config_dir_name}.conf.d/adapter.conf":
      owner   => $user,
      group   => $group,
      mode    => '0600',
      content => template('dmlite/plugins/adapter.conf.erb'),
      require => [Package['dmlite-plugins-adapter'], File["/etc/${config_dir_name}.conf.d"]]
    }
  }
}
