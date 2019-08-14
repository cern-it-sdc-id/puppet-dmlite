class dmlite::srm::service (
) inherits dmlite::srm::params {

  Class[lcgdm::ns::install] -> Class[dmlite::srm::service]

  Class[lcgdm::base::config] ~> Class[dmlite::srm::service]

  service { 'srmv2.2':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::srm::config'], Class['dmlite::srm::install']],
    subscribe  => File[$lcgdm::ns::config::configfile,
                "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::cert",
                "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::certkey"],
  }
 #centOS7 changes
 if versioncmp($facts['os']['release']['major'], '7') >= 0 {

   file{'/etc/systemd/system/multi-user.target.wants/srmv2.2.service':
     ensure => 'link',
     target => '/usr/share/dpm-mysql/srmv2.2.service',
   } ->
   file{'/etc/systemd/system/srmv2.2.service':
     ensure => link,
     target => '/usr/share/dpm-mysql/srmv2.2.service',
   }
    -> Service['srmv2.2']
 }

}
