class dmlite::config::disk (
  $enable_config  = $dmlite::params::enable_config,
  $user           = $dmlite::params::user,
  $group          = $dmlite::params::group,
  $log_level      = $dmlite::params::log_level,
  $logcomponents  = $dmlite::params::logcomponents
) inherits dmlite::params {

  Class[dmlite::install] -> Class[dmlite::config::disk]

  if defined ('xrootd::service'){
    Class[dmlite::config::disk] ~> Class[xrootd::service]
  }
  if defined ('dmlite::dav::service'){
    Class[dmlite::config::disk] ~> Class[dmlite::dav::service]
  }
  if defined ('gridftp::service'){
    Class[dmlite::config::disk] ~> Class[gridftp::service]
  }
  if defined (Class[dmlite::dome::service]){
    Class[dmlite::config::disk] ~> Class[dmlite::dome::service]
  }

  # the head config is needed for xrootd and gridftp
  dmlite::create_config{'head_config':
    config_file_name => 'dmlite',
    user             => $user,
    group            => $group,
    enable_config    => $enable_config,
    log_level        => $log_level,
    logcomponents    => $logcomponents
  }

  dmlite::create_config{'disk_config_http':
    config_file_name => 'dmlite-disk',
    user             => $user,
    group            => $group,
    enable_config    => $enable_config,
    log_level        => $log_level,
    logcomponents    => $logcomponents
  }
}

