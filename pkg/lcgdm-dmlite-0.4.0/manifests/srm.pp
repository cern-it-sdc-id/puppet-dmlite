class dmlite::srm (
  $dbflavor = $dmlite::srm::params::dbflavor,
  $user     = $dmlite::srm::params::user,
  $group    = $dmlite::srm::params::group,
  $dpmhost  = $dmlite::srm::params::dpmhost,
  $nshost   = $dmlite::srm::params::nshost,
) inherits dmlite::srm::params {

  Class[dmlite::srm::install] -> Class[dmlite::srm::config] -> Class[dmlite::srm::service]

  class{'dmlite::srm::install':
    user  => "${user}",
    group => "${group}"
  }
  class{'dmlite::srm::config':
    dbflavor => "${dbflavor}",
    dpmhost  => "${dpmhost}",
    nshost   => "${nshost}"
  }
  class{'dmlite::srm::service':}

}
