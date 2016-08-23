class dmlite::dav::config (
  $dmlite_conf        = $dmlite::dav::params::dmlite_conf,
  $dmlite_disk_conf   = $dmlite::dav::params::dmlite_disk_conf,
  $ns_type            = $dmlite::dav::params::ns_type,
  $ns_prefix          = $dmlite::dav::params::ns_prefix,
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
  #dav ports
  $dav_http_port      = 80,
  $dav_https_port     = 443,
) inherits dmlite::dav::params {

  validate_bool($enable_ns)
  validate_bool($enable_disk)
  validate_bool($enable_https)
  validate_bool($enable_http)

  case $enable_hdfs {
    true:{
      $dav_template = 'dmlite/dav/zlcgdm-dav_hdfs.conf'
    }
    default: {
      $dav_template = 'dmlite/dav/zlcgdm-dav.conf'
    }
  }

  Class[dmlite::dav::install] -> Class[dmlite::dav::config]

  # some installations don't have complete data types enabled by default, use
  # str2bool to catch both cases
  if(str2bool("${::selinux}") != false) {
    selboolean{'httpd_can_network_connect': value => on, persistent => true }
    selboolean{'httpd_execmem': value => on, persistent => true }
  }

  if $enable_hdfs {
    include dmlite::plugins::hdfs::params
    $java_home= $dmlite::plugins::hdfs::params::java_home
    file {
      '/etc/sysconfig/httpd':
        ensure  => present,
        owner   => $user,
        group   => $group,
        content => template('dmlite/dav/sysconfig.erb'),
	notify => Class[dmlite::dav::service]
    }
  }

  #enable cors
  $domain_string = regsubst("${::domain}", '\.', '\\.', 'G')
  file {
      '/etc/httpd/conf.d/cross-domain.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        content => template('dmlite/dav/cross-domain.conf.erb'),
	notify => Class[dmlite::dav::service]
  }
  #enable mpm_conf
  file {
      '/etc/httpd/conf.d/mpm_event.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        content => template('dmlite/dav/mpm_event.conf'),
	notify => Class[dmlite::dav::service]
  }

  file {
    '/etc/httpd/conf.d/ssl.conf':
      ensure  => present,
      content => ''; # empty content, so an upgrade doesn't overwrite it
    '/etc/httpd/conf.d/zgridsite.conf':
      ensure  => present,
      content => ''; # empty content, so an upgrade doesn't overwrite it
    '/etc/httpd/conf.d/zlcgdm-dav.conf':
      ensure  => present,
      content => template("${dav_template}");
  }

  # We need some additional tweaks to the httpd.conf.
  # Probably goes away if we start using a puppet module for apache.
  file_line {
    'no apache mod_dav':
      ensure => absent,
      line   => 'LoadModule dav_module modules/mod_dav.so',
      path   => '/etc/httpd/conf/httpd.conf';
    'no apache mod_dav_fs':
      ensure => absent,
      line   => 'LoadModule dav_fs_module modules/mod_dav_fs.so',
      path   => '/etc/httpd/conf/httpd.conf';
    'apache user':
      ensure => present,
      match  => '^User .*',
      line   => "User ${user}",
      path   => '/etc/httpd/conf/httpd.conf';
    'apache group':
      ensure => present,
      match  => '^Group .*',
      line   => "Group ${group}",
      path   => '/etc/httpd/conf/httpd.conf';
  }
  if $coredump_dir {
    file_line {'apache coredump':
      ensure => present,
      line   => "CoreDumpDirectory ${coredump_dir}",
      path   => '/etc/httpd/conf/httpd.conf'
    }
  }

  if $enable_keep_alive {
  file_line { 'apache keepalive':
      ensure => present,
      line   => 'KeepAlive On',
      path   => '/etc/httpd/conf/httpd.conf',
      match  => '^KeepAlive .*'
    }
  }

  file_line{'mpm model':
    ensure => present,
    path   => '/etc/sysconfig/httpd',
    line   => "HTTPD=${mpm_model}",
    match  => '^#?HTTPD=/.*'
  }

  if $ulimit {
    file_line {'apache ulimit':
      ensure => present,
      line   => "ulimit ${ulimit}",
      path   => '/etc/sysconfig/httpd'
    }
  }
 #centOS7 changes
 if $::operatingsystemmajrelease and ($::operatingsystemmajrelease + 0) >= 7 { 
     file {
      '/etc/httpd/conf.modules.d/00-dav.conf':
        ensure  => absent,
     }

   file_line { 'mpm event':
      ensure => present,
      line   => 'LoadModule mpm_event_module modules/mod_mpm_event.so',
      path   => '/etc/httpd/conf.modules.d/00-mpm.conf',
      match  => '^#LoadModule mpm_event_module modules/mod_mpm_event.so'
    }

   file_line { 'mpm prefork':
      ensure => absent,
      line   => 'LoadModule mpm_prefork_module modules/mod_mpm_prefork.so',
      path   => '/etc/httpd/conf.modules.d/00-mpm.conf',
    }
  }
}
