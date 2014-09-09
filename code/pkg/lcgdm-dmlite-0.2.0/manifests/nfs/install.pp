class dmlite::nfs::install (
) inherits dmlite::nfs::params {

    package {
      "dpm-nfs-server":
        ensure => present;
    }
}
