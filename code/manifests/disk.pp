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
  $enable_space_reporting = true,
  $memcached_servers = [],
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

  	class{'dmlite::plugins::mysql::config':
    		mysql_host     => "${mysql_host}",
    		mysql_username => "${mysql_username}",
    		mysql_password => "${mysql_password}",
    		dbpool_size    => 2,
    		enable_dpm     => false,
    		enable_ns      => true,
    		enable_io      => true,       
    		mysql_dir_space_report_depth => 6,
  	}

  	class{'dmlite::plugins::mysql::install':}

	validate_array($memcached_servers)

        if size($memcached_servers) == 0 {
                fail("please specify at least one memcached server address via memcached_servers variable")
        }

        class{"dmlite::plugins::memcache":
		enable_memcache_cat => true,
                servers          => $memcached_servers,
	        expiration_limit => 600,
        	posix            => 'on',
		pool_size        => 10,
        }

  }
}
