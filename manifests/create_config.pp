define dmlite::create_config (
  $config_file_name,
  $enable_config    = $dmlite::params::enable_config,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group,
  $log_level        = $dmlite::params::log_level,
  $logcomponents    = $dmlite::params::logcomponents
) {
  include dmlite::params

  Class[Dmlite::Params] -> Dmlite::Create_config <| |>

  $libdir = $dmlite::params::libdir

  file {"/etc/${config_file_name}.conf":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => '0600',
    content => template('dmlite/dmlite.conf.erb')
  }

  file {"/etc/${config_file_name}.conf.d":
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0700'
  }
}
