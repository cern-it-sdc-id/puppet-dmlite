class dmlite::dav::service (
) inherits dmlite::dav::params {

  Class[dmlite::dav::config] ~> Class[dmlite::dav::service]

  $certificates_files = File["/etc/grid-security/$dmlite::base::config::user/$dmlite::base::config::cert",
                             "/etc/grid-security/$dmlite::base::config::user/$dmlite::base::config::certkey"]

  service { 'httpd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::dav::config'], Class['dmlite::dav::install']],
    subscribe  => $certificates_files,
  }
}
