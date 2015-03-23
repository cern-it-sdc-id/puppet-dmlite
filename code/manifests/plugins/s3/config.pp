class dmlite::plugins::s3::config (
  $timeout            = $dmlite::plugins::s3::params::timeout,
  $enable_pool_driver = $dmlite::plugins::s3::params::enable_pool_driver,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group
) inherits dmlite::plugins::s3::params {

  if defined ('xrootd::service'){
    Class[Dmlite::Plugins::s3::Config] ~> Class[Xrootd::Service]
  }
  if defined ('dmlite::dav::service'){
    Class[Dmlite::Plugins::s3::Config] ~> Class[Dmlite::Dav::Service]
  }
  if defined ('gridftp::service'){
    Class[Dmlite::Plugins::s3::Config] ~> Class[Gridftp::Service]
  }

  file {
    '/etc/dmlite.conf.d/s3.conf':
      ensure  => present,
      owner   => $user,
      group   => $group,
      mode    => '0600',
      content => template('dmlite/plugins/s3.conf.erb'),
      require => Package['dmlite-plugins-s3']
  }
}
