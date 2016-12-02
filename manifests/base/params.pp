class dmlite::base::params {
  $libdir = $architecture ? {
    'x86_64' => 'lib64',
    default  => 'lib',
  }

  $user = 'dpmmgr'
  $cert = 'dpmcert.pem'
  $certkey = 'dpmkey.pem'
  $uid = undef
  $gid = undef
  $egiCA = true
}
