class dmlite::plugins::adapter::config::head (
  $dpm_host           = $dmlite::plugins::adapter::params::dpm_host,
  $ns_host            = $dmlite::plugins::adapter::params::ns_host,
  $connection_timeout = $dmlite::plugins::adapter::params::connection_timeout,
  $retry_limit        = $dmlite::plugins::adapter::params::retry_limit,
  $retry_interval     = $dmlite::plugins::adapter::params::retry_interval,

  $token_password     = $dmlite::params::token_password,
  $token_id           = $dmlite::params::token_id,
  $token_life         = $dmlite::params::token_life,
  $enable_config      = $dmlite::params::enable_config
) inherits dmlite::plugins::adapter::params {

  Class[Dmlite::Plugins::Adapter::Install] -> Class[Dmlite::Plugins::Adapter::Config::Head]

  dmlite::plugins::adapter::create_config{"head_config":
    config_dir_name    => "dmlite",   # put file in /etc/dmlite.conf.d/adapter.conf
    dpm_host           => $dpm_host,
    ns_host            => $ns_host,
    connection_timeout => $connection_timeout,
    retry_limit        => $retry_limit,
    retry_interval     => $retry_interval,
    enable_dpm         => false,
    enable_io          => false,
    enable_rfio        => true,
    enable_ns          => false,
    enable_pooldriver  => true,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
    enable_config      => $enable_config
  }

  dmlite::plugins::adapter::create_config{"disk_config_http":
    config_dir_name    => "dmlite-disk",   # put file in /etc/dmlite.conf.d/adapter.conf
    dpm_host           => $dpm_host,
    ns_host            => $ns_host,
    connection_timeout => $connection_timeout,
    retry_limit        => $retry_limit,
    retry_interval     => $retry_interval,
    enable_dpm         => false,
    enable_io          => false,
    enable_rfio        => true,
    enable_ns          => false,
    enable_pooldriver  => false,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
    enable_config      => $enable_config
  }
}

