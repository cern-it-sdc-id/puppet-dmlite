class dmlite::install (
  $debuginfo = false
) inherits dmlite::params {

  validate_bool($debuginfo)

  package {"dmlite-libs":
    ensure => present;
  }

  if $debuginfo {
    package {"dmlite-debuginfo":
      ensure => present;
    }
  }

}
