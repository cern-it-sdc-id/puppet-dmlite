class dmlite::config (
    $token_password	= $dmlite::params::token_password,
    $token_id		= $dmlite::params::token_id,
    $token_life		= $dmlite::params::token_life,
    $enable_config	= $dmlite::params::enable_config
) inherits dmlite::params {

    file {
      "/etc/dmlite.conf":
        require	=> Class["dmlite::install"];
      "/etc/dmlite.conf.d":
        ensure	=> directory,
        require	=> File["/etc/dmlite.conf"];
    }
}

