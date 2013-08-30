
class dmlite::gridftp (
    $detach			= 1,
    $disable_usage_stats	= 1,
    $log_single			= "/var/log/dpm-gsiftp/gridftp.log",
    $log_transfer		= "/var/log/dpm-gsiftp/dpm-gsiftp.log",
    $log_level			= "ALL",
    $port			= 2811
) {

    package{"dpm-dsi": ensure => present}

    # gridftp configuration
    file { 
	"/var/log/dpm-gsiftp": 
		ensure => directory 
    }
    class{"gridftp::config": 
	auth_level		=> 0,
	detach			=> $detach,
	disable_usage_stats	=> $disable_usage_stats,
	load_dsi_module 	=> "dmlite",
	log_single		=> $log_single,
	log_transfer		=> $log_transfer,
	log_level		=> $log_level,
	login_msg		=> "Disk Pool Manager (dmlite)",
	port			=> $port,
	thread_model		=> "pthread",

    }
    class{"gridftp::install":}
    class{"gridftp::service":
        require => Package["dpm-dsi"]
    }
}

