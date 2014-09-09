
class dmlite::nfs::service (
) inherits dmlite::nfs::params {

    service {"dpm-nfs":
    	ensure		=> running,
	hasstatus	=> true,
	hasrestart	=> true,
	enable		=> true,
	require		=> [ Class["dmlite::nfs::config"], Class["dmlite::nfs::install"] ],
    }
}
