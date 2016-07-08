
class dmlite::gridftp (
  $detach              = 1,
  $disable_usage_stats = 1,
  $log_single          = '/var/log/dpm-gsiftp/gridftp.log',
  $log_transfer        = '/var/log/dpm-gsiftp/dpm-gsiftp.log',
  $log_level           = 'ERROR,WARN,INFO',
  $port                = 2811,
  $dpmhost             = $::fqdn,
  $nshost              = $::fqdn,
  $user                = $dmlite::params::user,
  $group               = $dmlite::params::group,
  $enable_hdfs         = false,
  $data_node           = 0,
  $remote_nodes        = undef,
) {
  File['/var/log/dpm-gsiftp'] -> Class[gridftp::config]
  Package['dpm-dsi'] -> Class[gridftp::config]
  Package['dpm-dsi'] -> File['/etc/sysconfig/dpm-gsiftp']
  Class['gridftp::config'] -> Exec['remove_globus-gridftp-server_init_management']
  Class[dmlite::gridftp] ~> Class['gridftp::service']
  Class[lcgdm::base::config] -> Class[dmlite::gridftp]

  if $enable_hdfs {
    $java_home = $dmlite::plugins::hdfs::params::java_home
  }

  package{'dpm-dsi': ensure => present}

  file {
    '/etc/sysconfig/dpm-gsiftp':
      ensure  => present,
      owner   => $user,
      group   => $group,
      content => template('dmlite/gridftp/sysconfig.erb')
  }

  # gridftp configuration
  file {
    '/var/log/dpm-gsiftp':
      ensure => directory,
      owner  => $user,
      group  => $group,
  }
  class{'gridftp::install':}
  class{'gridftp::config':
    user                => "${user}",
    group               => "${group}",
    auth_level          => 0,
    detach              => $detach,
    disable_usage_stats => $disable_usage_stats,
    load_dsi_module     => 'dmlite',
    log_single          => $log_single,
    log_transfer        => $log_transfer,
    log_level           => $log_level,
    login_msg           => 'Disk Pool Manager (dmlite)',
    port                => $port,
    service             => 'dpm-gsiftp',
    sysconfigfile       => '/etc/sysconfig/globus',
    thread_model        => 'pthread',
    data_node           => $data_node,
    remote_nodes        => "${remote_nodes}",
  }
  exec{'remove_globus-gridftp-server_init_management':
    command => '/sbin/chkconfig globus-gridftp-server off',
    onlyif  => '/sbin/chkconfig globus-gridftp-server'
  }

  include dmlite::gaiconfig

  class{'gridftp::service':
    service => 'dpm-gsiftp',
    certificate => "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::cert",
    key => "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::certkey",
  }
}

