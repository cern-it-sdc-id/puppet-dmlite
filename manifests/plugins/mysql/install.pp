class dmlite::plugins::mysql::install (
  $uninstall = false,
) inherits dmlite::plugins::mysql::params {

  include dmlite

  if !$uninstall {
    package {
      'dmlite-plugins-mysql':
        ensure => present;
    }
  }

}
