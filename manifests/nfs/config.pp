class dmlite::nfs::config (
  $nshost     = $dmlite::nfs::params::nshost,
  $dpmhost    = $dmlite::nfs::params::dpmhost,
  $debuglevel = $dmlite::nfs::params::debuglevel,
  $maxfscalls = $dmlite::nfs::params::maxfscalls,
  $exportid   = $dmlite::nfs::params::exportid,
  $exportpath = $dmlite::nfs::params::exportpath,
  $rootaccess = $dmlite::nfs::params::rootaccess,
  $pseudopath = $dmlite::nfs::params::pseudopath,
  $sectype    = $dmlite::nfs::params::sectype,
  $fsid       = $dmlite::nfs::params::fsid,
  $cachedata  = $dmlite::nfs::params::cachedata
) inherits dmlite::nfs::params {

    file {
      '/etc/sysconfig/dpm-nfs':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template('dmlite/nfs/sysconfig.erb');
      '/etc/dpm-nfs.conf':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template('dmlite/nfs/dpm-nfs.conf.erb');
    }

}
