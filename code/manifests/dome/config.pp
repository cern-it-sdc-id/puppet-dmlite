class dmlite::dome::config (
  $dmlite_conf        = $dmlite::dav::params::dmlite_conf,
  $dome_http_port      = 80,
  $dome_https_port     = 443,
) inherits dmlite::dome::params {

  #validate_bool($enable_http)

  $dome_template = 'dmlite/dav/zlcgdm-dav.conf'


  Class[dmlite::dome::install] -> Class[dmlite::dome::config]

  # some installations don't have complete data types enabled by default, use
  # str2bool to catch both cases
  if(str2bool("${::selinux}") != false) {
    selboolean{'httpd_can_network_connect': value => on, persistent => true }
    selboolean{'httpd_execmem': value => on, persistent => true }
  }

  #enable cors
  $domain_string = regsubst("${::domain}", '\.', '\\.', 'G')
  file {
      '/etc/httpd/conf.d/cross-domain.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        content => template('dmlite/dav/cross-domain.conf.erb')
  }

  #tweaks
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
