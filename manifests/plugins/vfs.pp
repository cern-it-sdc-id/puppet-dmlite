class dmlite::plugins::vfs(
  $enable_vfs         = $dmlite::plugins::vfs::params::enable_vfs,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group,

  $token_password,
  $token_id           = $dmlite::plugins::vfs::params::token_id,
  $token_life         = $dmlite::plugins::vfs::params::token_life,

  $catalog_path       = $dmlite::plugins::vfs::params::catalog_path,
  $data_path          = $dmlite::plugins::vfs::params::data_path,
) inherits dmlite::plugins::vfs::params {

  Class[dmlite::plugins::vfs::install] -> Class[dmlite::plugins::vfs::config]

  class{'dmlite::plugins::vfs::config':
    enable_vfs     => $enable_vfs,
    user           => "${user}",
    group          => "${group}",
    token_password => "${token_password}",
    token_id       => "${token_id}",
    token_life     => "${token_life}",
    catalog_path   => "${catalog_path}",
    data_path      => "${data_path}",
  }
  class{'dmlite::plugins::vfs::install':}

}
