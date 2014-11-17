class dmlite::nfs::params (
) inherits dmlite::params {

  $nshost     = $fqdn
  $dpmhost    = $nshost
  $debuglevel = "NIV_FULL_DEBUG"
  $maxfscalls = 10
  $exportid   = 1
  $exportpath = "/"
  $rootaccess = "*"
  $pseudopath = "/grid"
  $sectype    = "sys"
  $fsid       = "100.1"
  $cachedata  = "FALSE"
}
