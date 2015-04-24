class dmlite::plugins::hdfs::params (
) inherits dmlite::params {
    $enable_hdfs  = true
    $enable_pool_driver = true
    $enable_ns = false
    $enable_io = false
    $hdfs_namenode = undef
    $hdfs_port = undef
    $hdfs_user = undef
    $hdfs_mode = rw
    $hdfs_gateway = "${::fqdn}"
    $hdfs_tmp_folder = '/tmp'
    $hadoop_home_lib = '/usr/lib/hadoop'
    $hdfs_home_lib = '/usr/lib/hadoop-hdfs'
    $java_home = '/usr/lib/jvm/java/'
    $token_password = 'change-this'
    $map_file = '/etc/lcgdm-mapfile'
    $token_id = ip
    $token_life = 1000
}
