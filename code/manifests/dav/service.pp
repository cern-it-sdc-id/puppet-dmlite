
class dmlite::dav::service (
) inherits dmlite::dav::params {

    service {"httpd":
    	ensure		=> running,
	hasstatus	=> true,
	hasrestart	=> true,
	enable		=> true,
	require		=> [ Class["dmlite::dav::config"], Class["dmlite::dav::install"] ],
    }
}
