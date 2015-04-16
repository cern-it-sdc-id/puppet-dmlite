class dmlite::disk (
  $token_password,
  $token_id   = 'ip',
  $mysql_username,
  $mysql_password,
  $mysql_host = 'localhost',
  $mysql_dir_space_report_depth = 6,
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $debuginfo  = false,
  $log_level      = 1,
  $logcomponents  = undef,
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

  class{'dmlite::plugins::mysql::config':
    mysql_host     => "${mysql_host}",
    mysql_username => "${mysql_username}",
    mysql_password => "${mysql_password}",
    dbpool_size    => 2,
    enable_dpm     => false,
    enable_ns      => false,
    enable_io      => true,       
    mysql_dir_space_report_depth => 6,
  }

  class{'dmlite::plugins::mysql::install':}
}
