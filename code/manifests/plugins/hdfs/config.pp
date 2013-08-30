class dmlite::plugins::hdfs::config (
    $enable_hdfs	= $dmlite::plugins::hdfs::params::enable_hdfs
) inherits dmlite::plugins::hdfs::params {

    file {
      "/etc/dmlite.conf.d/hdfs.conf":
        content => template("dmlite/plugins/hdfs.conf.erb"),
        require => Package["dmlite-plugins-hdfs"]
    }
}
