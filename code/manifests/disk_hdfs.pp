class dmlite::disk_hdfs (
  $token_password,
  $token_id   = 'ip',
  $token_life = 1000,
  $mysql_username,
  $mysql_password,
  $mysql_host = 'localhost',
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $adminuser  = undef,
  $debuginfo  = false,
  $log_level      = 1,
  $logcomponents  = undef,
  $hdfs_namenode  = undef,
  $hdfs_port      = undef,
  $hdfs_user      = undef,
  $hdfs_mode      = 'rw',
  $hdfs_tmp_folder = '/tmp',
  $enable_io      = true,
  $hdfs_replication = 3,
) {
  class{'dmlite::config::head':
    log_level     => $log_level,
    logcomponents => $logcomponents
  }
  class{'dmlite::install':
    debuginfo => $debuginfo
  }

  Class[Dmlite::Plugins::Hdfs::Install] -> Class[Dmlite::Plugins::Hdfs::Config]

  class { 'dmlite::plugins::hdfs::config':
    token_password  => "${token_password}",
    token_id        => "${token_id}",
    token_life      => "${token_life}",
    hdfs_namenode   => "${hdfs_namenode}",
    hdfs_port       => "${hdfs_port}",
    hdfs_user       => "${hdfs_user}",
    hdfs_mode       => "${hdfs_mode}",
    hdfs_tmp_folder => "${hdfs_tmp_folder}",
    enable_io       => "${enable_io}",
    hdfs_replication => "${hdfs_replication}",
  }
  class{'dmlite::plugins::hdfs::install':}

  class{'dmlite::plugins::mysql::config':
    mysql_host     => "${mysql_host}",
    mysql_username => "${mysql_username}",
    mysql_password => "${mysql_password}",
    adminuser      => "${adminuser}",
  }

  class{'dmlite::plugins::mysql::install':}
}
