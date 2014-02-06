class dmlite::plugins::vfs::config (
  $enable_vfs         = $dmlite::plugins::vfs::params::enable_vfs,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group,

  $token_password,
  $token_id           = $dmlite::plugins::vfs::params::token_id,
  $token_life         = $dmlite::plugins::vfs::params::token_life,
) inherits dmlite::plugins::vfs::params {

  file {
    "/etc/dmlite.conf.d/vfs.conf":
      owner   => $user,
      group   => $group,
      mode    => 0600,
      content => template("dmlite/plugins/vfs.conf.erb"),
      require => Package["dmlite-plugins-vfs"]
  }
}
