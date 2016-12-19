class dmlite::base (
  $uid     = $dmlite::base::params::uid,
  $gid     = $dmlite::base::params::gid,
  $cert    = $dmlite::base::params::cert,
  $certkey = $dmlite::base::params::certkey,
  $user    = $dmlite::base::params::user,) 
inherits dmlite::base::params {

  class { 'dmlite::base::config':
    uid     => $uid,
    gid     => $gid,
    cert    => $cert,
    certkey => $certkey,
    user    => $user,
  }

  class { 'dmlite::base::install':
  }
}
