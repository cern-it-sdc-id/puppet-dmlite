class dmlite::shell::install (
) inherits dmlite::dav::params {

    package {
      'dmlite-shell':
        ensure => present;
    }

}
