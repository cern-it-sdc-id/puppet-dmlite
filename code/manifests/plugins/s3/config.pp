class dmlite::plugins::s3::config (
    $timeout		= $dmlite::plugins::s3::params::timeout,
    $enable_pool_driver	= $dmlite::plugins::s3::params::enable_pool_driver
) inherits dmlite::plugins::s3::params {

    file {
      "/etc/dmlite.conf.d/s3.conf":
        content => template("dmlite/plugins/s3.conf.erb"),
        require => Package["dmlite-plugins-s3"]
    }
}
