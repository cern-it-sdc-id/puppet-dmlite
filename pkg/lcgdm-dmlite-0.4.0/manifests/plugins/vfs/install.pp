class dmlite::plugins::vfs::install (
) inherits dmlite::plugins::vfs::params {

  include dmlite

  package {'dmlite-plugins-vfs':
    ensure => present;
  }

}
