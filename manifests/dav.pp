class dmlite::dav (
  $dmlite_conf        = $dmlite::dav::params::dmlite_conf,
  $dmlite_disk_conf   = $dmlite::dav::params::dmlite_disk_conf,
  $ns_type            = $dmlite::dav::params::ns_type,
  $ns_prefix          = $dmlite::dav::params::ns_prefix,
  $disk_prefix        = $dmlite::dav::params::disk_prefix,
  $ns_flags           = $dmlite::dav::params::ns_flags,
  $ns_anon            = $dmlite::dav::params::ns_anon,
  $ns_max_replicas    = $dmlite::dav::params::ns_max_replicas,
  $ns_secure_redirect = $dmlite::dav::params::ns_secure_redirect,
  $ns_trusted_dns     = $dmlite::dav::params::ns_trusted_dns,
  $disk_flags         = $dmlite::dav::params::disk_flags,
  $disk_anon          = $dmlite::dav::params::disk_anon,
  $ssl_cert           = $dmlite::dav::params::ssl_cert,
  $ssl_key            = $dmlite::dav::params::ssl_key,
  $ssl_capath         = $dmlite::dav::params::ssl_capath,
  $ssl_options        = $dmlite::dav::params::ssl_options,
  $log_error          = $dmlite::dav::params::log_error,
  $log_transfer       = $dmlite::dav::params::log_transfer,
  $log_level          = $dmlite::dav::params::log_level,
  $user               = $dmlite::dav::params::user,
  $group              = $dmlite::dav::params::group,
  $coredump_dir       = $dmlite::dav::params::coredump_dir,
  $ulimit             = $dmlite::dav::params::ulimit,
  $enable_ns          = $dmlite::dav::params::enable_ns,
  $enable_disk        = $dmlite::dav::params::enable_disk,
  $enable_https       = $dmlite::dav::params::enable_https,
  $enable_http        = $dmlite::dav::params::enable_http,
  $enable_keep_alive  = $dmlite::dav::params::enable_keep_alive,
  $mpm_model          = $dmlite::dav::params::mpm_model,
  $enable_hdfs        = $dmlite::dav::params::enable_hdfs,
  $libdir             = $dmlite::dav::params::libdir,
  #dav ports
  $dav_http_port      = 80,
  $dav_https_port     = 443,
) inherits dmlite::dav::params {

  Class[dmlite::dav::install] -> Class[dmlite::dav::config] ~> Class[dmlite::dav::service]

  include('dmlite::dav::install')
  include('dmlite::dav::config')
  include('dmlite::dav::service')

}
