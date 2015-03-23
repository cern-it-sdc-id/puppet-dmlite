class dmlite::plugins::hdfs::config (
  $enable_hdfs        = $dmlite::plugins::hdfs::params::enable_hdfs,
  $enable_ns          = $dmlite::plugins::hdfs::params::enable_ns,
  $enable_pool_driver = $dmlite::plugins::hdfs::params::enable_pool_driver,
  $enable_io          = $dmlite::plugins::hdfs::params::enable_io,
  $hdfs_namenode      = $dmlite::plugins::hdfs::params::hdfs_namenode,
  $hdfs_port          = $dmlite::plugins::hdfs::params::hdfs_port,
  $hdfs_user          = $dmlite::plugins::hdfs::params::hdfs_user,
  $hdfs_mode          = $dmlite::plugins::hdfs::params::hdfs_mode,
  $hdfs_gateway       = $dmlite::plugins::hdfs::params::hdfs_gateway,
  $hdfs_tmp_folder    = $dmlite::plugins::hdfs::params::hdfs_tmp_folder,
  $hadoop_home_lib    = $dmlite::plugins::hdfs::params::hadoop_home_lib,
  $hdfs_home_lib      = $dmlite::plugins::hdfs::params::hdfs_home_lib,
  $java_home          = $dmlite::plugins::hdfs::params::java_home,
  $token_password     = $dmlite::plugins::hdfs::params::token_password,
  $token_id           = $dmlite::plugins::hdfs::params::token_id,
  $token_life         = $dmlite::plugins::hdfs::params::token_life,
  $map_file           = $dmlite::plugins::hdfs::params::map_file,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group,

) inherits dmlite::plugins::hdfs::params {

  if defined ('xrootd::service'){
    Class[Dmlite::Plugins::Hdfs::Config] ~> Class[Xrootd::Service]
  }
  if defined ('dmlite::dav::service'){
    Class[Dmlite::Plugins::Hdfs::Config] ~> Class[Dmlite::Dav::Service]
  }
  if defined ('gridftp::service'){
    Class[Dmlite::Plugins::Hdfs::Config] ~> Class[Gridftp::Service]
  }
  
  file {
    '/etc/dmlite.conf.d/hdfs.conf':
      owner   => $user,
      group   => $group,
      mode    => '0600',
      content => template('dmlite/plugins/hdfs.conf.erb'),
      require => Package['dmlite-plugins-hdfs']
  }
}
