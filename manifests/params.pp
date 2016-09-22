class dmlite::params {
  $libdir = $::architecture ? {
    'x86_64' => 'lib64',
    default  => 'lib',
  }

  $enable_config  = hiera('dmlite::params::enable_config', true)
  $user           = hiera('dmlite::params::user', 'dpmmgr')
  $group          = hiera('dmlite::params::group', 'dpmmgr')
  $log_level      = hiera('dmlite::params::log_level', 1)
  $logcomponents  = hiera('dmlite::params::logcomponents', [])

}
