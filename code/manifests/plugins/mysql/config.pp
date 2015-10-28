class dmlite::plugins::mysql::config (
  $mysql_host       = $dmlite::plugins::mysql::params::mysql_host,
  $mysql_username   = $dmlite::plugins::mysql::params::mysql_username,
  $mysql_password,
  $mysql_port       = $dmlite::plugins::mysql::params::mysql_port,
  $mysql_dir_space_report_depth = $dmlite::plugins::mysql::params::mysql_dir_space_report_depth,
  $ns_db            = $dmlite::plugins::mysql::params::ns_db,
  $dpm_db           = $dmlite::plugins::mysql::params::dpm_db,
  $dbpool_size      = $dmlite::plugins::mysql::params::dbpool_size,
  $mapfile          = $dmlite::plugins::mysql::params::mapfile,
  $host_dn_is_root  = $dmlite::plugins::mysql::params::host_dn_is_root,
  $host_cert        = $dmlite::plugins::mysql::params::host_cert,
  $enable_dpm       = $dmlite::plugins::mysql::params::enable_dpm,
  $enable_ns        = $dmlite::plugins::mysql::params::enable_ns,
  $enable_io        = $dmlite::plugins::mysql::params::enable_io,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group,
  $adminuser        = undef,
) inherits dmlite::plugins::mysql::params {

  if defined ('xrootd::service'){
    Class[Dmlite::Plugins::Mysql::Config] ~> Class[Xrootd::Service]
  }
  if defined ('dmlite::dav::service'){
    Class[Dmlite::Plugins::Mysql::Config] ~> Class[Dmlite::Dav::Service]
  }
  if defined ('gridftp::service'){
    Class[Dmlite::Plugins::Mysql::Config] ~> Class[Gridftp::Service]
  }
     if $::domain == "cern.ch" {
        teigi::secret::sub_file{"/etc/dmlite.conf.d/mysql.conf":
          teigi_keys => ['mysql_password'],
          owner   => $user,
          group   => $group,
          mode    => '0600',
          template => 'dmlite/plugins/mysql.conf.CERN.erb',
          require => Package['dmlite-plugins-mysql']
        }

         if $enable_io {
            teigi::secret::sub_file{"/etc/dmlite-disk.conf.d/mysql.conf": 
		  teigi_keys => ['mysql_password'],
                  owner   => $user,
                  group   => $group,
                  mode    => '0600',
                  template => 'dmlite/plugins/mysql.conf.CERN.erb',
                  require => Package['dmlite-plugins-mysql']
            }
    	}

      }
      else {

         file {
           '/etc/dmlite.conf.d/mysql.conf':
           owner   => $user,
           group   => $group,
           mode    => '0600',
           content => template('dmlite/plugins/mysql.conf.erb'),
           require => Package['dmlite-plugins-mysql']
         }

         if $enable_io {
	    file {
      		'/etc/dmlite-disk.conf.d/mysql.conf':
	          owner   => $user,
        	  group   => $group,
        	  mode    => '0600',
	          content => template('dmlite/plugins/mysql.conf.erb'),
	          require => Package['dmlite-plugins-mysql']
    	  }
      }
   }

}
