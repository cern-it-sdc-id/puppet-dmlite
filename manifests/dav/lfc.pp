class dmlite::dav::lfc (
  $dmlite_conf        = $dmlite::dav::dmlite_conf,
  $dmlite_disk_conf   = $dmlite::dav::dmlite_disk_conf,
  $ns_type            = $dmlite::dav::ns_type,
  $ns_prefix          = $dmlite::dav::ns_prefix,
  $disk_prefix        = $dmlite::dav::disk_prefix,
  $ns_flags           = $dmlite::dav::ns_flags,
  $ns_anon            = $dmlite::dav::ns_anon,
  $ns_max_replicas    = $dmlite::dav::ns_max_replicas,
  $ns_secure_redirect = $dmlite::dav::ns_secure_redirect,
  $ns_trusted_dns     = $dmlite::dav::ns_trusted_dns,
  $disk_flags         = $dmlite::dav::disk_flags,
  $disk_anon          = $dmlite::dav::disk_anon,
  $ssl_cert           = $dmlite::dav::ssl_cert,
  $ssl_key            = $dmlite::dav::ssl_key,
  $ssl_capath         = $dmlite::dav::ssl_capath,
  $ssl_options        = $dmlite::dav::ssl_options,
  $log_error          = $dmlite::dav::log_error,
  $log_transfer       = $dmlite::dav::log_transfer,
  $log_level          = $dmlite::dav::log_level,
  $user               = $dmlite::dav::user,
  $group              = $dmlite::dav::group,
  $coredump_dir       = $dmlite::dav::coredump_dir,
  $ulimit             = $dmlite::dav::ulimit,
  $enable_ns          = $dmlite::dav::enable_ns,
  $enable_disk        = $dmlite::dav::enable_disk,
  $enable_https       = $dmlite::dav::enable_https,
  $enable_http        = $dmlite::dav::enable_http,
  $enable_keep_alive  = $dmlite::dav::enable_keep_alive,
  $mpm_model          = $dmlite::dav::mpm_model,
  $enable_hdfs        = $dmlite::dav::enable_hdfs,
  $libdir             = $dmlite::dav::libdir,
  $dav_http_port      = $dmlite::dav::dav_http_port,
  $dav_https_port     = $dmlite::dav::dav_https_port,
) {

  Class[dmlite::dav::install] -> Class[dmlite::dav::config] -> Class[dmlite::dav::service]

  class{'dmlite::dav::install':}
  class{'dmlite::dav::config':
    ns_type      => 'LFC',
    ns_prefix    => 'grid',
    ns_flags     => 'NoAuthn',
    enable_disk  => false,
    enable_http  => true,
    enable_https => true,
    user         => 'lfcmgr',
    group        => 'lfcmgr',
  }
  class{'dmlite::dav::service':}

}
