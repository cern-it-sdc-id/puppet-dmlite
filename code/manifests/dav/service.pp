class dmlite::dav::service (
) inherits dmlite::dav::params {

  Class[dmlite::dav::config] ~> Class[dmlite::dav::service]

  file{$dmlite::dav::params::ssl_cert:
	ensure => present
  }
  file{$dmlite::dav::params::ssl_key:
        ensure => present
  }

  $certificates_files = File[$dmlite::dav::params::ssl_cert,$dmlite::dav::params::ssl_key ]

  service { 'httpd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::dav::config'], Class['dmlite::dav::install']],
    subscribe => $certificates_files,
  }
}
