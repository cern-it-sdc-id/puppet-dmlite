class dmlite::plugins::mysql::install (
) inherits dmlite::plugins::mysql::params {

  include dmlite

  package {'dmlite-plugins-mysql':
    ensure => present;
  }

}
