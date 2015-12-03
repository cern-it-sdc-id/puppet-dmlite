class dmlite::srm::params (
) inherits dmlite::params {

  $dbflavor   = 'mysql'
  $active     = 'yes'
  $ulimitn    = hiera('dmlite::srm::ulimitn', 65000)
  $coredump   = hiera('dmlite::srm::coredump', 'no')
  $dpmhost    = $::fqdn
  $nshost     = $::fqdn
  $numthreads = hiera('dmlite::srm::numthreads', 99)
  $user       = 'dpmmgr'
  $group      = 'dpmmgr'

}
