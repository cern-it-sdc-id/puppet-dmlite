class dmlite::head (
  $token_password,
  $token_id        = 'ip',
  $mysql_username,
  $mysql_password,
  $mysql_host      = 'localhost',
  $dpm_db          = "dpm_db",
  $ns_db           = "cns_db",
  $dpmhost         = "${::fqdn}",
  $nshost          = "${::fqdn}",
  $dbhost          = "${::fqdn}",
  $domain          = undef,
  $volist          = undef,
  $legacy          = true,
  $mysqlrootpass   = "",
  $dbmanage        = true,
  $uid             = '151',
  $gid             = '151',
  $adminuser       = undef,
  $debuginfo       = false,
  $log_level       = 1,
  $logcomponents   = undef,
  $enable_space_reporting = false,
  $enable_dome     = false,
  $enable_disknode = false,
  $enable_domeadapter = false,
) {
  class{'dmlite::config::head':
    log_level     => $log_level,
    logcomponents => $logcomponents
  }
  class{'dmlite::install':
    debuginfo => $debuginfo
  }
  if $enable_domeadapter and $enable_space_reporting{
    fail("'enable_domeadapter' and 'enable_space_reporting' options are mutual exclusive")
  }
  
  if !$legacy {

    validate_bool($dbmanage)

    #
    # Base configuration
    #
    if !defined(Class['dmlite::base']) {
      if gid != undef {
        class { 'dmlite::base':
          uid => $uid,
          gid => $gid,
        }
      } else {
        class { 'dmlite::base':
          uid => $uid,
          gid => $uid,
        }
      }
    }
  
    #
    # In case the DB is not local we should configure the file /root/.my.cnf

    if $dbhost != 'localhost' and $dbhost != "${::fqdn}" and $dbmanage {
        #check if root pass is empty
        if empty($mysqlrootpass ) {
                fail("mysqlrootpass parameter  should  not be empty")
        }
        #create the /root/.my.cnf
        file { '/root/.my.cnf':
          ensure => present,
          mode   => '0655',
          content => template('dmlite/mysql/my.cnf.erb'),
          before => Class[dmlite::db::head]
        }
    }
    #db conf
    package{'dmlite-dpmhead':
      ensure => present
    } ->
    class{'dmlite::db:::dpm':
      dbuser => "${mysql_username}",
      dbpass => "${mysql_password}",
      dbhost => "${mysql_host}",
    } ->
    class{'dmlite::db:::ns': 
      flavor => 'mysql',
      dbuser => "${mysql_username}", 
      dbpass => "${mysql_password}",
      dbhost => "${mysql_host}",
    }

  }

  if $enable_domeadapter and $enable_dome {
    class{'dmlite::plugins::domeadapter::config::head':
      token_password => "${token_password}",
      token_id       => "${token_id}",
      adminuser      => "${adminuser}",
      dome_head_url  => "https://${::fqdn}/domehead",
      dome_disk_url  => "https://${::fqdn}/domedisk",
      disknode       => $enable_disknode,
    }
    class{'dmlite::plugins::domeadapter::install':}
     
    class{'dmlite::plugins::adapter::install':
      uninstall      => true,
    }
    class{'dmlite::plugins::adapter::config::head':
      token_password => "${token_password}",
      empty_conf     => true,
    }
  } else {
    class{'dmlite::plugins::adapter::config::head':
      token_password => "${token_password}",
      token_id       => "${token_id}",
      dpmhost        => "${dpmhost}",
      nshost         => "${nshost}",
      adminuser      => "${adminuser}",
      with_db_plugin => true,
    }
    class{'dmlite::plugins::adapter::install':}

    class{'dmlite::plugins::domeadapter::config::head':
     token_password => "${token_password}",
      empty_conf     => true,
    }

    class{'dmlite::plugins::domeadapter::install':
      uninstall      => true,
    }
  }

  class{'dmlite::plugins::mysql::config':
    mysql_host     => "${mysql_host}",
    mysql_username => "${mysql_username}",
    mysql_password => "${mysql_password}",
    ns_db          => "${ns_db}",
    dpm_db         => "${dpm_db}",
    adminuser      => "${adminuser}",
    enable_io      => $enable_space_reporting,
    enable_dpm     => !$enable_domeadapter,
  }

  class{'dmlite::plugins::mysql::install':}

  if $enable_dome {
          
     exec{'upgradedb350':
       command => "/bin/sh /usr/share/dmlite/dbscripts/upgrade/DPM_upgrade_mysql ${mysql_host} ${mysql_username} ${mysql_password}",
       unless => "/bin/sh /usr/share/dmlite/dbscripts/upgrade/check_schema_version ${mysql_host} ${mysql_username} ${mysql_password}",
       require => Class['dmlite::db::head']
     }
     if $enable_disknode {
       #install the metapackage for disk
       package{'dmlite-dpmdisk':
         ensure => present,
        }
      }
      class{'dmlite::dome::config':
        dome_head    => true,
        dome_disk    => $enable_disknode,
        db_host      => "${mysql_host}",
        db_user      => "${mysql_username}",
        db_password  => "${mysql_password}",
        headnode_domeurl =>"https://${dpmhost}/domehead",
      } 
      class{'dmlite::dome::install':}
      ->
      class{'dmlite::dome::service':}
  }

  if !$legacy {
    #
    # Create path for domain and VOs to be enabled.
    #
    validate_array($volist)
      
    dmlite::dpm::domain { "${domain}": }

    dmlite::dpm::vo { $volist: 
      domain => "${domain}",
    }
  }
}
