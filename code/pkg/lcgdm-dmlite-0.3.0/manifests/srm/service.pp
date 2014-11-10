class dmlite::srm::service (
) inherits dmlite::srm::params {

    Class[Dmlite::Srm::Service] -> Class[Lcgdm::Ns::Install]

    service {"srmv2.2":
    	ensure		=> running,
	hasstatus	=> true,
	hasrestart	=> true,
	enable		=> true,
	require		=> [ Class["dmlite::srm::config"], Class["dmlite::srm::install"] ],
        subscribe       => File["$lcgdm::ns::config::configfile"]
    }
}
