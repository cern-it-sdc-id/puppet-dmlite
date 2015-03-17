class dmlite::plugins::adapter::install (
  $debuginfo = false
) inherits dmlite::plugins::adapter::params {

  include dmlite

  package {
    'dmlite-plugins-adapter':
      ensure => present;
  }

  if $debuginfo {
    package {'dmlite-plugins-adapter-debuginfo':
      ensure => present;
    }
  }

}
