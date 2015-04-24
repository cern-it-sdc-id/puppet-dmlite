class dmlite::dav::service (
) inherits dmlite::dav::params {

  Class[Dmlite::Dav::Config] ~> Class[Dmlite::Dav::Service]

  service { 'httpd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::dav::config'], Class['dmlite::dav::install']],
  }
}
