
class dmlite::gridftp (
  $detach              = 1,
  $disable_usage_stats = 1,
  $log_single          = "/var/log/dpm-gsiftp/gridftp.log",
  $log_transfer        = "/var/log/dpm-gsiftp/dpm-gsiftp.log",
  $log_level           = "ALL",
  $port                = 2811
) {
  File["/var/log/dpm-gsiftp"] -> Class[Gridftp::Config]
  Package["dpm-dsi"] -> Class[Gridftp::Config]

  package{"dpm-dsi": ensure => present}

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
    thread_model        => "pthread",
    service             => "dpm-gsiftp"
  }
  class{"gridftp::service":
    service => "dpm-gsiftp"
  }
}

