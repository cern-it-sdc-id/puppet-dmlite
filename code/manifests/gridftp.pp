
class dmlite::gridftp (
  $detach              = 1,
  $disable_usage_stats = 1,
  $log_single          = "/var/log/dpm-gsiftp/gridftp.log",
  $log_transfer        = "/var/log/dpm-gsiftp/dpm-gsiftp.log",
  $log_level           = "ALL",
  $port                = 2811,
  $dpmhost,
  $nshost              = $dpmhost
) {
  File["/var/log/dpm-gsiftp"] -> Class[Gridftp::Config]
  Package["dpm-dsi"] -> Class[Gridftp::Config]
  Package["dpm-dsi"] -> File["/etc/sysconfig/dpm-gsiftp"]

  package{"dpm-dsi": ensure => present}

  file {
    "/etc/sysconfig/dpm-gsiftp":
      ensure  => present,
      content => template("dmlite/gridftp/sysconfig.erb")
  }

  # gridftp configuration
  file {
    "/var/log/dpm-gsiftp":
      ensure => directory
  }
  class{"gridftp::install":}
  class{"gridftp::config":
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
  class{"gridftp::service":
    service => "dpm-gsiftp"
  }
}

