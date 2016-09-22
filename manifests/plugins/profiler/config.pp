class dmlite::plugins::profiler::config (
  $enable_profiler  = $dmlite::plugins::profiler::params::enable_profiler,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group,
  $collectors       = $dmlite::plugins::profiler::params::collectors,
  $auth             = $dmlite::plugins::profiler::params::auth,
) inherits dmlite::plugins::profiler::params {

  validate_array($collectors)

  if defined ('xrootd::service'){
    Class[dmlite::plugins::profiler::config] ~> Class[xrootd::service]
  }
  if defined ('dmlite::dav::service'){
    Class[dmlite::plugins::profiler::config] ~> Class[dmlite::dav::service]
  }
  if defined ('gridftp::service'){
    Class[dmlite::plugins::profiler::config] ~> Class[gridftp::service]
  }
  file {
    '/etc/dmlite.conf.d/profiler.conf':
      owner   => $user,
      group   => $group,
      mode    => '0600',
      content => template('dmlite/plugins/profiler.conf.erb'),
      require => Package['dmlite-plugins-profiler']
  }
  file {
    '/etc/dmlite-disk.conf.d/profiler.conf':
      owner   => $user,
      group   => $group,
      mode    => '0600',
      content => template('dmlite/plugins/profiler.conf.erb'),
      require => Package['dmlite-plugins-profiler']
  }
}
