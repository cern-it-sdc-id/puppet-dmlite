class dmlite::plugins::adapter::config (
  $config_dir_name    = "dmlite",
  $dpm_host           = $dmlite::plugins::adapter::params::dpm_host,
  $ns_host            = $dmlite::plugins::adapter::params::ns_host,
  $connection_timeout = $dmlite::plugins::adapter::params::connection_timeout,
  $retry_limit        = $dmlite::plugins::adapter::params::retry_limit,
  $retry_interval     = $dmlite::plugins::adapter::params::retry_interval,
  $enable_dpm         = $dmlite::plugins::adapter::params::enable_dpm,
  $enable_io          = $dmlite::plugins::adapter::params::enable_io,
  $enable_rfio        = $dmlite::plugins::adapter::params::enable_rfio,
  $enable_ns          = $dmlite::plugins::adapter::params::enable_ns,
  $enable_pooldriver  = $dmlite::plugins::adapter::params::enable_pooldriver,

  $token_password     = $dmlite::params::token_password,
  $token_id           = $dmlite::params::token_id,
  $token_life         = $dmlite::params::token_life,
  $enable_config      = $dmlite::params::enable_config
) inherits dmlite::plugins::adapter::params {

  Class[Dmlite::Plugins::Adapter::Install] -> Class[Dmlite::Plugins::Adapter::Config]

  dmlite::plugins::adapter::create_config{"default_config":
    config_dir_name    => $config_dir_name,   # put file in /etc/dmlite.conf.d/adapter.conf
    dpm_host           => $dpm_host,
    ns_host            => $ns_host,
    connection_timeout => $connection_timeout,
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
    enable_config      => $enable_config
  }
}
