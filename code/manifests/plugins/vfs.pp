class dmlite::plugins::vfs(
  $enable_vfs         = $dmlite::plugins::vfs::params::enable_vfs,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group,

  $token_password,
  $token_id           = $dmlite::plugins::vfs::params::token_id,
  $token_life         = $dmlite::plugins::vfs::params::token_life,
) inherits dmlite::plugins::vfs::params {

  Class[Dmlite::Plugins::Vfs::Install] -> Class[Dmlite::Plugins::Vfs::Config]

  class{"dmlite::plugins::vfs::config":
    enable_vfs     => $enable_vfs,
    user           => "${user}",
    group          => "${group}",
    token_password => "${token_password}",
    token_id       => "${token_id}",
    token_life     => "${token_life}",
  }
  class{"dmlite::plugins::vfs::install":}

}
