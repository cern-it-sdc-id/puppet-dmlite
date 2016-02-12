class dmlite::dome::install (
) inherits dmlite::dome::params {

    package {
      'mod_fastcgi':
        ensure => present;
    }

}
