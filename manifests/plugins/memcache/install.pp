class dmlite::plugins::memcache::install (
) inherits dmlite::plugins::memcache::params {

  include dmlite

  package {'dmlite-plugins-memcache':
    ensure => present;
  }

}
