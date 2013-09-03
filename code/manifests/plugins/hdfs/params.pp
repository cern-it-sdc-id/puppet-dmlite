class dmlite::plugins::hdfs::params (
) inherits dmlite::params {
    $enable_pool_driver = true
    $enable_ns = false
    $enable_io = false
    $hdfs_namenode = undef
    $hdfs_port = undef
    $hdfs_user = undef
    $hdfs_mode = rw
    $hadoop_home_lib = "/usr/lib/hadoop"
    $hdfs_home_lib = "/usr/lib/hadoop-hdfs"
    $java_home = "/usr/java/latest"
    $token_password = change-this
    $token_id = ip
    $token_life = 1000

    $enable_hdfs  = true
}
