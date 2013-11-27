class dmlite::config::lfc (
  $enable_config  = $dmlite::params::enable_config,
  $user           = $dmlite::params::user,
  $group          = $dmlite::params::group
) inherits dmlite::params {

  Class[Dmlite::Install] -> Class[Dmlite::Config::Lfc]

  dmlite::create_config{"head_config":
    config_file_name => "dmlite",   # create /etc/dmlite.conf
    user             => $user,
    group            => $group,
    enable_config    => $enable_config
  }
}