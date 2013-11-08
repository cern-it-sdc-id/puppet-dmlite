class dmlite::params {
  $libdir = $architecture ? {
    "x86_64" => "lib64",
    default  => "lib",
  }

  $enable_config  = true
  $user           = $lcgdm::base::config::user
  $group          = $lcgdm::base::config::group

}
