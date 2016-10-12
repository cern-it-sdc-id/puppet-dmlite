class dmlite::plugins::adapter::install (
  $debuginfo = false,
  $uninstall = false,
) inherits dmlite::plugins::adapter::params {

  include dmlite

  if !$uninstall {
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
}
