class dmlite::plugins::domeadapter::install (
  $debuginfo = false
) inherits dmlite::plugins::domeadapter::params {

  include dmlite

  package {
    'dmlite-plugins-domeadapter':
      ensure => present;
  }

  if $debuginfo {
    package {'dmlite-plugins-domeadapter-debuginfo':
      ensure => present;
    }
  }

}
