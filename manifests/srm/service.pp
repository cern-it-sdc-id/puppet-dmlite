class dmlite::srm::service (
) inherits dmlite::srm::params {

    Class[Lcgdm::Ns::Install] -> Class[Dmlite::Srm::Service]

  service { 'srmv2.2':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::srm::config'], Class['dmlite::srm::install']],
    subscribe  => File["${lcgdm::ns::config::configfile}"]
  }
}
