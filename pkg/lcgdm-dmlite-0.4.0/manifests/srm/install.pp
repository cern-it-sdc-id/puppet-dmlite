class dmlite::srm::install (
  $user  = $dmlite::srm::params::user,
  $group = $dmlite::srm::params::group,
) inherits dmlite::srm::params {

    package {
      "dpm-srm-server-${dmlite::srm::params::dbflavor}":
        ensure => present
    }

    file {
      '/var/log/srmv2.2':
        ensure => directory,
        owner  => "${user}",
        group  => "${group}",
        mode   => '0600';
      '/var/log/srmv2.2/log':
        ensure => present,
        owner  => "${user}",
        group  => "${group}",
        mode   => '0600',
        require=> File['/var/log/srmv2.2'];
    }

}
