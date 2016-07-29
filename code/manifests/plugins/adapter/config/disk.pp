class dmlite::plugins::adapter::config::disk (
  $dpmhost            = $dmlite::plugins::adapter::params::dpmhost,
  $nshost             = $dmlite::plugins::adapter::params::nshost,
  $connection_timeout = $dmlite::plugins::adapter::params::connection_timeout,
  $connection_poolsize = $dmlite::plugins::adapter::params::connection_poolsize,
  $retry_limit        = $dmlite::plugins::adapter::params::retry_limit,
  $retry_interval     = $dmlite::plugins::adapter::params::retry_interval,

  $token_password,
  $token_id           = $dmlite::plugins::adapter::params::token_id,
  $token_life         = $dmlite::plugins::adapter::params::token_life,
) inherits dmlite::plugins::adapter::params {

  Class[dmlite::plugins::adapter::install] -> Class[dmlite::plugins::adapter::config::disk]

  dmlite::plugins::adapter::create_config{'head_config':
    config_dir_name    => 'dmlite',   # put file in /etc/dmlite.conf.d/adapter.conf
    dpmhost            => $dpmhost,
    nshost             => $nshost,
    connection_timeout => $connection_timeout,
    connection_poolsize => $connection_poolsize,
    retry_limit        => $retry_limit,
    retry_interval     => $retry_interval,
    enable_dpm         => true,
    enable_io          => false,
    enable_rfio        => true,
    enable_ns          => false,
    enable_pooldriver  => false,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
  }

  dmlite::plugins::adapter::create_config{'disk_config_http':
    config_dir_name    => 'dmlite-disk',   # put file in /etc/dmlite.conf.d/adapter.conf
    dpmhost            => $dpmhost,
    nshost             => $nshost,
    connection_timeout => $connection_timeout,
    connection_poolsize => $connection_poolsize,
    retry_limit        => $retry_limit,
    retry_interval     => $retry_interval,
    enable_dpm         => true,
    enable_io          => false,
    enable_rfio        => true,
    enable_ns          => false,
    enable_pooldriver  => false,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
  }
}


