class dmlite::plugins::hdfs::config (
    $enable_hdfs	= $dmlite::plugins::hdfs::params::enable_hdfs,
    $enable_ns		= $dmlite::plugins::hdfs::params::enable_ns,
    $enable_pool_driver = $dmlite::plugins::hdfs::params::enable_pool_driver,
    $enable_io 		= $dmlite::plugins::hdfs::params::enable_io,
    $hdfs_namenode      = $dmlite::plugins::hdfs::params::hdfs_namenode,
    $hdfs_port		= $dmlite::plugins::hdfs::params::hdfs_port,
    $hdfs_user		= $dmlite::plugins::hdfs::params::hdfs_user,
    $hdfs_mode 		= $dmlite::plugins::hdfs::params::hdfs_mode,
    $hadoop_home_lib 	= $dmlite::plugins::hdfs::params::hadoop_home_lib,
    $hdfs_home_lib      = $dmlite::plugins::hdfs::params::hdfs_home_lib,
    $java_home          = $dmlite::plugins::hdfs::params::java_home,
    $token_password     = $dmlite::plugins::hdfs::params::token_password,
    $token_id           = $dmlite::plugins::hdfs::params::token_id,
    $token_life		= $dmlite::plugins::hdfs::params::token_life

) inherits dmlite::plugins::hdfs::params {

    file {
      "/etc/dmlite.conf.d/hdfs.conf":
        content => template("dmlite/plugins/hdfs.conf.erb"),
        require => Package["dmlite-plugins-hdfs"]
    }
}
