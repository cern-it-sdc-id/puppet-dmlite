class dmlite::dome::service (
) inherits dmlite::dome::params {

  Class[dmlite::dome::config] ~> Class[dmlite::dome::service]

  service { 'httpd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::dome::config'], Class['dmlite::dome::install']],
  }
}
