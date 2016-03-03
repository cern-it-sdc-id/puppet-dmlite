class dmlite::srm::service (
) inherits dmlite::srm::params {

    Class[lcgdm::ns::install] -> Class[dmlite::srm::service]

  service { 'srmv2.2':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::srm::config'], Class['dmlite::srm::install']],
    subscribe  => File[$lcgdm::ns::config::configfile]
  }
 #centOS7 changes
 if $::operatingsystemmajrelease and ($::operatingsystemmajrelease + 0) >= 7 {

   file{'/etc/systemd/system/multi-user.target.wants/srmv2.2.service':
     ensure => 'link',
     target => '/usr/share/dpm-mysql/srmv2.2.service',
   }
   file{'/etc/systemd/system/srmv2.2.service':
     ensure => link,
     target => '/usr/share/dpm-mysql/srmv2.2.service',
   }
 }

}
