class dmlite::disk (
  $token_password,
  $token_id   = 'ip',
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $debuginfo  = false,
  $log_level      = $dmlite::params::log_level,
  $logcomponents  = $dmlite::params::logcomponents
) {
  class { 'dmlite::config::head':
    log_level     => $log_level,
    logcomponents => $logcomponents
  }
  class{'dmlite::install':
    debuginfo => $debuginfo
  }
  class{'dmlite::plugins::adapter::config::disk':
    token_password => "${token_password}",
    token_id       => "${token_id}",
    dpmhost        => "${dpmhost}",
    nshost         => "${nshost}"
  }
  class{'dmlite::plugins::adapter::install':}
}
