
class dmlite::dav::install (
) inherits dmlite::dav::params {

    package {
      "lcgdm-dav-server":
        ensure => present;
    }

}
