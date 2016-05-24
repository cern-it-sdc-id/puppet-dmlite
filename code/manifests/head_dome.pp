class dmlite::head_dome (
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

  class{'dmlite::plugins::domeadapter::config::head':
    token_password => "${token_password}",
    token_id       => "${token_id}",
    #adminuser      => "${adminuser}",
  }
  class{'dmlite::plugins::domeadapter::install':}

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

  class{'dmlite::dome::config': 
    dome_head    => true,
    dome_disk    => false,
    db_host      => "${mysql_host}",
    db_user 	 => "${mysql_username}",
    db_password	 => "${mysql_password}",
  }
  
  class{'dmlite::dome::install':}

  class{'dmlite::dome::service':}
}
