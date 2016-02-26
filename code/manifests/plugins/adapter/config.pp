class dmlite::plugins::adapter::config (
  $config_dir_name    = 'dmlite',
  $dpm_host            = $dmlite::plugins::adapter::params::dpmhost,
  $ns_host             = $dmlite::plugins::adapter::params::nshost,
  $connection_timeout = $dmlite::plugins::adapter::params::connection_timeout,
  $connection_poolsize = $dmlite::plugins::adapter::params::connection_poolsize,
  $retry_limit        = $dmlite::plugins::adapter::params::retry_limit,
  $retry_interval     = $dmlite::plugins::adapter::params::retry_interval,
  $enable_dpm         = $dmlite::plugins::adapter::params::enable_dpm,
  $enable_io          = $dmlite::plugins::adapter::params::enable_io,
  $enable_rfio        = $dmlite::plugins::adapter::params::enable_rfio,
  $enable_ns          = $dmlite::plugins::adapter::params::enable_ns,
  $enable_pooldriver  = $dmlite::plugins::adapter::params::enable_pooldriver,
  
  $token_password,
  $token_id           = $dmlite::plugins::adapter::params::token_id,
  $token_life         = $dmlite::plugins::adapter::params::token_life,
  $adminuser          = undef,
) inherits dmlite::plugins::adapter::params {

  Class[dmlite::plugins::adapter::install] -> Class[dmlite::plugins::adapter::config]

  dmlite::plugins::adapter::create_config{'default_config':
    config_dir_name    => $config_dir_name,   # put file in /etc/dmlite.conf.d/adapter.conf
    dpmhost            => $dpm_host,
    nshost             => $ns_host,
    connection_timeout => $connection_timeout,
    connection_poolsize => $connection_poolsize,
    retry_limit        => $retry_limit,
    retry_interval     => $retry_interval,
    enable_dpm         => $enable_dpm,
    enable_io          => $enable_io,
    enable_rfio        => $enable_rfio,
    enable_ns          => $enable_ns,
    enable_pooldriver  => $enable_pooldriver,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
  }
}
