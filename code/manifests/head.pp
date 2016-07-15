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
  $enable_dome   = false,
  $upgrade_db    = false,
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

  if $enable_dome {
          #install the metapackage for head
          package{'dmlite-dpm_head':
		 ensure => present
	  }

   	  if $upgrade_db {
		exec{'upgradedb350':
   		 command => "/bin/sh /usr/share/dmlite/dbscripts/upgrade/DPM_upgrade_mysql ${mysql_host} ${mysql_username} ${mysql_password} ${dpm_db} ${ns_db}",
		 require => Package['dmlite-dpm_head'],
		}
          }

	  class{'dmlite::dome::config':
	    dome_head    => true,
	    dome_disk    => false,
	    db_host      => "${mysql_host}",
	    db_user      => "${mysql_username}",
	    db_password  => "${mysql_password}",
	  } 
	  class{'dmlite::dome::install':}
	  ->
	  class{'dmlite::dome::service':}

  }
}
