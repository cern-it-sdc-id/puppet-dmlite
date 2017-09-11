class dmlite::dav::service (
) inherits dmlite::dav::params {

  Class[dmlite::dav::config] ~> Class[dmlite::dav::service]

  case $dmlite::dav::config::nstype  {
    'LFC': { $certfilename='lfccert.pem'; $keyfilename='lfckey.pem'}
    default: { $certfilename='dpmcert.pem'; $keyfilename='dpmkey.pem'}
  }

  $certificates_files = File["/etc/grid-security/$dmlite::dav::params::user/$certfilename",
                             "/etc/grid-security/$dmlite::dav::params::user/$keyfilename"]

  service { 'httpd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [Class['dmlite::dav::config'], Class['dmlite::dav::install']],
    subscribe  => $certificates_files,
  }
}
