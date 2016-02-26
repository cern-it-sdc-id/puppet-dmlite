class dmlite::plugins::s3::config (
  $timeout            = $dmlite::plugins::s3::params::timeout,
  $enable_pool_driver = $dmlite::plugins::s3::params::enable_pool_driver,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group
) inherits dmlite::plugins::s3::params {

  if defined ('xrootd::service'){
    Class[dmlite::plugins::s3::config] ~> Class[xrootd::service]
  }
  if defined ('dmlite::dav::service'){
    Class[dmlite::plugins::s3::config] ~> Class[dmlite::dav::service]
  }
  if defined ('gridftp::service'){
    Class[dmlite::plugins::s3::config] ~> Class[gridftp::service]
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
