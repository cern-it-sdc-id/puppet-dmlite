define dmlite::plugins::domeadapter::create_config (
  $config_dir_name    = 'dmlite',
  $enable_io          = $dmlite::plugins::domeadapter::params::enable_io,
  $enable_ns          = $dmlite::plugins::domeadapter::params::enable_ns,
  $enable_pooldriver  = $dmlite::plugins::domeadapter::params::enable_pooldriver,
  $davix_ca_path      = $dmlite::plugins::domeadapter::params::davix_ca_path,
  $davix_cert_path    = $dmlite::plugins::domeadapter::params::davix_cert_path,
  $davix_private_key_path = $dmlite::plugins::domeadapter::params::davix_private_key_path,
  $dome_head_url      = $dmlite::plugins::domeadapter::params::dome_head_url,
  $dome_disk_url      = $dmlite::plugins::domeadapter::params::dome_disk_url

  $token_password     = '',
  $token_id           = $dmlite::plugins::domeadapter::params::token_id,
  $token_life         = $dmlite::plugins::domeadapter::params::token_life,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group,
  $adminuser          = undef
) {
  Class[dmlite::params] -> Dmlite::Plugins::Domeadapter::Create_config <| |>

  $libdir = $dmlite::params::libdir

  if defined (Class[xrootd::service]){
    Dmlite::Plugins::Domeadapter::Create_config <| |> ~> Class[xrootd::service]
  }
  if defined (Class[dmlite::dav::service]){
    Dmlite::Plugins::Domeadapter::Create_config <| |> ~> Class[dmlite::dav::service]
  }
  if defined (Class[gridftp::service]){
    Dmlite::Plugins::Domeadapter::Create_config <| |> ~> Class[gridftp::service]
  }
  file {
      "/etc/${config_dir_name}.conf.d/domeadapter.conf":
      owner   => $user,
      group   => $group,
      mode    => '0750',
      content => template('dmlite/plugins/domeadapter.conf.erb'),
      require => [Package['dmlite-plugins-domeadapter'], File["/etc/${config_dir_name}.conf.d"]]
    }
  }
}
