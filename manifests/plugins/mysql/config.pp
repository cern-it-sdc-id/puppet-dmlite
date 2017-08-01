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
  $empty_conf       = false,
) inherits dmlite::plugins::mysql::params {

  if defined ('xrootd::service'){
    Class[dmlite::plugins::mysql::config] ~> Class[xrootd::service]
  }
  if defined ('dmlite::dav::service'){
    Class[dmlite::plugins::mysql::config] ~> Class[dmlite::dav::service]
  }
  if defined ('gridftp::service'){
    Class[dmlite::plugins::mysql::config] ~> Class[gridftp::service]
  }

  if $empty_conf {
    file {'/etc/dmlite.conf.d/mysql.conf':
          content => "",
          owner   => $user,
          group   => $group,
        }
    } else {
    file {'/etc/dmlite.conf.d/mysql.conf':
       owner   => $user,
       group   => $group,
       mode    => '0750',
       content => template('dmlite/plugins/mysql.conf.erb'),
       require => Package['dmlite-plugins-mysql']
    }
  }

  if $enable_io {
   file {'/etc/dmlite-disk.conf.d/mysql.conf':
       owner   => $user,
       group   => $group,
       mode    => '0750',
       content => template('dmlite/plugins/mysql.conf.erb'),
       require => Package['dmlite-plugins-mysql']
   }
  } else {
    file {'/etc/dmlite-disk.conf.d/mysql.conf':
      ensure => absent,  
    }
  }
}
