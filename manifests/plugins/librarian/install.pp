class dmlite::plugins::librarian::install (
) inherits dmlite::plugins::librarian::params {

  include dmlite

  package {'dmlite-plugins-librarian':
    ensure => present;
  }

}
