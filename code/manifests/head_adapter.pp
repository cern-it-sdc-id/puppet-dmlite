class dmlite::head_adapter (
  $token_password,
  $token_id   = "ip",
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $adminuser  = undef,
  $debuginfo  = false,
  $log_level      = $dmlite::params::log_level,
  $logcomponents  = $dmlite::params::logcomponents
) {
  class{"dmlite::config::head":
    log_level        => $log_level,
    logcomponents    => $logcomponents
  }
  class{"dmlite::install":
    debuginfo => $debuginfo
  }
  class{"dmlite::plugins::adapter::config::head":
    token_password => "${token_password}",
    token_id       => "${token_id}",
    dpmhost        => "${dpmhost}",
    nshost         => "${nshost}",
    adminuser      => "${adminuser}",
    with_db_plugin => false,
  }
  class{"dmlite::plugins::adapter::install":}

    file {
      "/etc/dmlite.conf.d/mysql.conf":
        ensure => absent,
    }
}

