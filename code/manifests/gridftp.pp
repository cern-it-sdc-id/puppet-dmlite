
class dmlite::gridftp (
  $detach              = 1,
  $disable_usage_stats = 1,
  $log_single          = "/var/log/dpm-gsiftp/gridftp.log",
  $log_transfer        = "/var/log/dpm-gsiftp/dpm-gsiftp.log",
  $log_level           = "ALL",
  $port                = 2811,
  $dpmhost,
  $nshost              = $dpmhost,
  $user                = $dmlite::params::user,
  $group               = $dmlite::params::group
) {
  File["/var/log/dpm-gsiftp"] -> Class[Gridftp::Config]
  Package["dpm-dsi"] -> Class[Gridftp::Config]
  Package["dpm-dsi"] -> File["/etc/sysconfig/dpm-gsiftp"]
  Class["Gridftp::Config"] -> Exec["remove_globus-gridftp-server_init_management"]

  package{"dpm-dsi": ensure => present}

  file {
    "/etc/sysconfig/dpm-gsiftp":
      ensure  => present,
      owner   => $user,
      group   => $group,
      content => template("dmlite/gridftp/sysconfig.erb")
  }

  # gridftp configuration
  file {
    "/var/log/dpm-gsiftp":
      owner  => $user,
      group  => $group,
      ensure => directory
  }
  class{"gridftp::install":}
  class{"gridftp::config":
    user                => "${user}",
    group               => "${group}",
    auth_level          => 0,
    detach              => $detach,
    disable_usage_stats => $disable_usage_stats,
    load_dsi_module     => "dmlite",
    log_single          => $log_single,
    log_transfer        => $log_transfer,
    log_level           => $log_level,
    login_msg           => "Disk Pool Manager (dmlite)",
    port                => $port,
    service             => "dpm-gsiftp",
    sysconfigfile       => "/etc/sysconfig/globus",
    thread_model        => "pthread"
  }
  exec{"remove_globus-gridftp-server_init_management":
    command => "/sbin/chkconfig globus-gridftp-server off"
  }
  class{"gridftp::service":
    service => "dpm-gsiftp"
  }
}

