class dmlite::config (
  $token_password = $dmlite::params::token_password,
  $token_id       = $dmlite::params::token_id,
  $token_life     = $dmlite::params::token_life,
  $enable_config  = $dmlite::params::enable_config,
  $user           = $dmlite::params::user,
  $group          = $dmlite::params::group
) inherits dmlite::params {

  Class[Dmlite::Install] -> Class[Dmlite::Config]

  dmlite::create_config{"default_config":
    config_file_name => "dmlite",   # create /etc/dmlite.conf
    user             => $user,
    group            => $group,
    token_password   => $token_password,
    token_id         => $token_id,
    token_life       => $token_life,
    enable_config    => $enable_config
  }
}

