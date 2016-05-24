class dmlite::dome::service (
) inherits dmlite::dome::params {

  Class[dmlite::dome::config] ~> Class[dmlite::dome::service]

  if dmlite::dome::config::dome_head {
  	service { 'domehead':
	    ensure     => running,
	    hasstatus  => true,
	    hasrestart => true,
	    enable     => true,
	    require    => [Class['dmlite::dome::config'], Class['dmlite::dome::install']],
	}
  }

  if dmlite::dome::config::dome_disk {

	service { 'domedisk':
            ensure     => running,
            hasstatus  => true,
            hasrestart => true,
            enable     => true,
            require    => [Class['dmlite::dome::config'], Class['dmlite::dome::install']],
        }

  }
}
