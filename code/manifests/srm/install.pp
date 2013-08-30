class dmlite::srm::install (
) inherits dmlite::srm::params {

    package {
      "dpm-srm-server-${dbflavor}":
        ensure => present
    }

    file {
      "/var/log/srmv2.2":
        owner  => dpmmgr,
        group  => dpmmgr,
        mode   => 600,
        ensure => directory;
      "/var/log/srmv2.2/log":
        owner  => dpmmgr,
        group  => dpmmgr,
        mode   => 600,
        ensure => present,
        require=> File["/var/log/srmv2.2"];
    }

}
