class dmlite::head (
  $token_password,
  $token_id   = 'ip',
  $mysql_username,
  $mysql_password,
  $mysql_host = 'localhost',
  $dpm_db     = "dpm_db",
  $ns_db      = "cns_db",
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $adminuser  = undef,
  $debuginfo  = false,
  $log_level      = 1,
  $logcomponents  = undef,
  $enable_space_reporting = false,
) {
  class{'dmlite::config::head':
    log_level     => $log_level,
    logcomponents => $logcomponents
  }
  class{'dmlite::install':
    debuginfo => $debuginfo
  }

  class{'dmlite::plugins::adapter::config::head':
    token_password => "${token_password}",
    token_id       => "${token_id}",
    dpmhost        => "${dpmhost}",
    nshost         => "${nshost}",
    adminuser      => "${adminuser}",
    with_db_plugin => true,
  }
  class{'dmlite::plugins::adapter::install':}

  class{'dmlite::plugins::mysql::config':
    mysql_host     => "${mysql_host}",
    mysql_username => "${mysql_username}",
    mysql_password => "${mysql_password}",
    ns_db          => "${ns_db}",
    dpm_db         => "${dpm_db}",
    adminuser      => "${adminuser}",
    enable_io      => $enable_space_reporting,
  }

  class{'dmlite::plugins::mysql::install':}
}
