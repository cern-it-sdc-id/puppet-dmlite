class dmlite::srm::install (
  $user  = $dmlite::srm::params::user,
  $group = $dmlite::srm::params::group,
) inherits dmlite::srm::params {

    package {
      "dpm-srm-server-${dbflavor}":
        ensure => present
    }

    file {
      "/var/log/srmv2.2":
        owner  => "${user}",
        group  => "${group}",
        mode   => 600,
        ensure => directory;
      "/var/log/srmv2.2/log":
        owner  => "${user}",
        group  => "${group}",
        mode   => 600,
        ensure => present,
        require=> File["/var/log/srmv2.2"];
    }

}
