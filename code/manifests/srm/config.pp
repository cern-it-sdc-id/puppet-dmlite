class dmlite::srm::config (
    $dbflavor	= $dmlite::srm::params::dbflavor,
    $active	= $dmlite::srm::params::active,
    $ulimitn	= $dmlite::srm::params::ulimitn,
    $coredump	= $dmlite::srm::params::coredump,
    $dpmhost	= $dmlite::srm::params::dpmhost,
    $nshost	= $dmlite::srm::params::nshost,
    $numthreads	= $dmlite::srm::params::numthreads
) inherits dmlite::srm::params {

   file {
      "/etc/sysconfig/srmv2.2":
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 644,
        content => template("dmlite/srm/sysconfig.erb");
    }
}
