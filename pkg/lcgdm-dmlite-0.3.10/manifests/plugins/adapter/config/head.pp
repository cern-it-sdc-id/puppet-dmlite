class dmlite::plugins::adapter::config::head (
  $dpmhost            = $dmlite::plugins::adapter::params::dpmhost,
  $nshost             = $dmlite::plugins::adapter::params::nshost,
  $connection_timeout = $dmlite::plugins::adapter::params::connection_timeout,
  $retry_limit        = $dmlite::plugins::adapter::params::retry_limit,
  $retry_interval     = $dmlite::plugins::adapter::params::retry_interval,
  $with_db_plugin     = $dmlite::plugins::adapter::params::with_db_plugin,

  $token_password,
  $token_id           = $dmlite::plugins::adapter::params::token_id,
  $token_life         = $dmlite::plugins::adapter::params::token_life,
  $adminuser          = undef,
) inherits dmlite::plugins::adapter::params {

  Class[Dmlite::Plugins::Adapter::Install] -> Class[Dmlite::Plugins::Adapter::Config::Head]

  if $with_db_plugin {
    $enable_ns = false
    $enable_dpm = false
  } else {
    $enable_ns = true
    $enable_dpm = true
  }

  dmlite::plugins::adapter::create_config{'head_config':
    config_dir_name    => 'dmlite',   # put file in /etc/dmlite.conf.d/adapter.conf
    dpmhost            => $dpmhost,
    nshost             => $nshost,
    connection_timeout => $connection_timeout,
    retry_limit        => $retry_limit,
    retry_interval     => $retry_interval,
    enable_dpm         => $enable_dpm,
    enable_io          => false,
    enable_rfio        => true,
    enable_ns          => $enable_ns,
    enable_pooldriver  => true,
    token_password     => $token_password,
    token_id           => $token_id,
    token_life         => $token_life,
    adminuser          => $adminuser,
  }

  dmlite::plugins::adapter::create_config{'disk_config_http':
    config_dir_name    => 'dmlite-disk',   # put file in /etc/dmlite.conf.d/adapter.conf
    dpmhost            => $dpmhost,
    nshost             => $nshost,
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
    adminuser          => $adminuser,
  }
}

