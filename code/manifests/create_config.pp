define dmlite::create_config (
  $config_file_name = "dmlite",
  $token_password   = $dmlite::params::token_password,
  $token_id         = $dmlite::params::token_id,
  $token_life       = $dmlite::params::token_life,
  $enable_config    = $dmlite::params::enable_config
) {
  include dmlite::params

  Class[Dmlite::Params] -> Dmlite::Create_config <| |>

  $libdir = $dmlite::params::libdir

  file {"/etc/${config_file_name}.conf":
    ensure  => present,
    content => template("dmlite/dmlite.conf.erb")
  }

  file {"/etc/${config_file_name}.conf.d":
    ensure => directory
  }
}
