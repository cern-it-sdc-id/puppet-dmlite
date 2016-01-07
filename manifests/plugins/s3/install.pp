class dmlite::plugins::s3::install (
) inherits dmlite::plugins::s3::params {

  include dmlite

  package {'dmlite-plugins-s3':
    ensure => present;
  }

}
