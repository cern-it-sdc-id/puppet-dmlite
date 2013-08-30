class dmlite::srm::service (
) inherits dmlite::srm::params {

    service {"srmv2.2":
    	ensure		=> running,
	hasstatus	=> true,
	hasrestart	=> true,
	enable		=> true,
	require		=> [ Class["dmlite::srm::config"], Class["dmlite::srm::install"] ]
    }
}
