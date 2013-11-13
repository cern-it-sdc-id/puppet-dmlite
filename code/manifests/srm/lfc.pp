class dmlite::srm::lfc (
  $dbflavor = $dmlite::srm::params::dbflavor,
  $user     = "lfcmgr",
  $group    = "lfcmgr",
) inherits dmlite::srm::params {

  Class[Dmlite::Srm::Install] -> Class[Dmlite::Srm::Config] -> Class[Dmlite::Srm::Service]

  class{"dmlite::srm::install":
    user  => "${user}",
    group => "${group}"
  }
  class{"dmlite::srm::config":
    dbflavor => "${dbflavor}"
  }
  class{"dmlite::srm::service":}

}
