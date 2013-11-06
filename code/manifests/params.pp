class dmlite::params {
    $libdir = $architecture ? {
      "x86_64" => "lib64",
      default  => "lib",
    }

    $token_password = "change-this"
    $token_id       = "ip"
    $token_life     = 1000
    $enable_config  = true
    $user           = $lcgdm::base::config::user
    $group          = $lcgdm::base::config::group

}
