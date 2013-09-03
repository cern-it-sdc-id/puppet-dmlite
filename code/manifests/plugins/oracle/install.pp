class dmlite::plugins::oracle::install (
) inherits dmlite::plugins::oracle::params {

  include dmlite

  package {"dmlite-plugins-oracle":
    ensure => present;
  }

}
