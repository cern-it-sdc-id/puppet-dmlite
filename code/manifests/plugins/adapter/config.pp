class dmlite::plugins::adapter::config (
    $dpm_host		= $dmlite::plugins::adapter::params::dpm_host,
    $ns_host		= $dmlite::plugins::adapter::params::ns_host,
    $connection_timeout	= $dmlite::plugins::adapter::params::connection_timeout,
    $retry_limit	= $dmlite::plugins::adapter::params::retry_limit,
    $retry_interval	= $dmlite::plugins::adapter::params::retry_interval,
    $enable_dpm		= $dmlite::plugins::adapter::params::enable_dpm,
    $enable_io		= $dmlite::plugins::adapter::params::enable_io,
    $enable_rfio	= $dmlite::plugins::adapter::params::enable_rfio,
    $enable_ns		= $dmlite::plugins::adapter::params::enable_ns,
    $enable_pooldriver	= $dmlite::plugins::adapter::params::enable_pooldriver,

    $token_password     = $dmlite::params::token_password,
    $token_id           = $dmlite::params::token_id,
    $token_life         = $dmlite::params::token_life,
    $enable_config      = $dmlite::params::enable_config
) inherits dmlite::plugins::adapter::params {

    file {
      "/etc/dmlite.conf.d/adapter.conf":
        content => template("dmlite/plugins/adapter.conf.erb"),
        require => Package["dmlite-plugins-adapter"]
    }
}
