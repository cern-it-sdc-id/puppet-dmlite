class dmlite::disk (
  $token_password,
  $token_id   = 'ip',
  $mysql_username = undef,
  $mysql_password = undef,
  $mysql_host = undef,
  $mysql_dir_space_report_depth = 6,
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $debuginfo  = false,
  $log_level      = 1,
  $logcomponents  = undef,
  $enable_space_reporting = false,
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

  if $enable_space_reporting {

         if $mysql_username == undef { 
		fail("'mysql_username' not defined") 
	 }
	 if $mysql_password == undef {
                fail("'mysql_password' not defined")
         }
	 if $mysql_host == undef {
                fail("'mysql_host' not defined")
         }

  	class{'dmlite::plugins::mysql::config':
    		mysql_host     => "${mysql_host}",
    		mysql_username => "${mysql_username}",
    		mysql_password => "${mysql_password}",
    		dbpool_size    => 10,
    		enable_dpm     => false,
    		enable_ns      => true,
    		enable_io      => true,       
    		mysql_dir_space_report_depth => $mysql_dir_space_report_depth,
  	}

  	class{'dmlite::plugins::mysql::install':}

  }
}
