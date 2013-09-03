class dmlite::plugins::hdfs::install (
) inherits dmlite::plugins::hdfs::params {

  include dmlite

  package {"dmlite-plugins-hdfs":
    ensure => present;
  }

}
