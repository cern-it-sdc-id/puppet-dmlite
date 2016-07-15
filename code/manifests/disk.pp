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
  $enable_dome = false,
  $headnode_domeurl = undef,
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


  if $enable_dome {
	#install the metapackage for disk
        package{'dmlite-dpm_disk':
            ensure => present,
        }
        if $headnode_domeurl == undef {
	    $_headnode_domeurl = "https://${dpmhost}/domehead"
	}
	else {
	    $_headnode_domeurl = $headnode_domeurl
	}
	class{'dmlite::dome::config':
	    dome_head    => false,
	    dome_disk    => true,
	    headnode_domeurl => "${headnode_domeurl}",
	}
	class{'dmlite::dome::install':}
	->
	class{'dmlite::dome::service':}
  }

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
