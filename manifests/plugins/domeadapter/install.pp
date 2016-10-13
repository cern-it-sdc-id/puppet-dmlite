class dmlite::plugins::domeadapter::install (
  $debuginfo = false,
  $uninstall = false,
) inherits dmlite::plugins::domeadapter::params {

  include dmlite
  
  if !$uninstall {
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

}
