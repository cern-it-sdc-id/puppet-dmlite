class dmlite::config (
  $enable_config  = $dmlite::params::enable_config,
  $user           = $dmlite::params::user,
  $group          = $dmlite::params::group,
  $log_level      = $dmlite::params::log_level,
  $logcomponents  = $dmlite::params::logcomponents
) inherits dmlite::params {

  Class[dmlite::install] -> Class[dmlite::config]

  dmlite::create_config{'default_config':
    config_file_name => 'dmlite',   # create /etc/dmlite.conf
    user             => $user,
    group            => $group,
    enable_config    => $enable_config,
    log_level        => $log_level,
    logcomponents    => $logcomponents
  }

  #ensure syslog is properly configured
  file_line{'rsyslogd':
    ensure => present,
    path   => '/etc/rsyslog.conf',
    line   => '$IncludeConfig /etc/rsyslog.d/*.conf',
  }
}
