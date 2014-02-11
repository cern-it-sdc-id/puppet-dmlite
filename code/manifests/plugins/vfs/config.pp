class dmlite::plugins::vfs::config (
  $enable_vfs         = $dmlite::plugins::vfs::params::enable_vfs,
  $user               = $dmlite::params::user,
  $group              = $dmlite::params::group,

  $token_password,
  $token_id           = $dmlite::plugins::vfs::params::token_id,
  $token_life         = $dmlite::plugins::vfs::params::token_life,

  $catalog_path       = $dmlite::plugins::vfs::params::catalog_path,
  $data_path          = $dmlite::plugins::vfs::params::data_path,
) inherits dmlite::plugins::vfs::params {

  file {
    "${catalog_path}":
        ensure => directory,
        owner  => "dpmmgr",
        group  => "dpmmgr",
        mode   => 0775;
    "${data_path}":
        ensure => directory,
        owner  => "dpmmgr",
        group  => "dpmmgr",
        seltype => "httpd_sys_content_t",
        mode   => 0775;
  }

  file {
    "/etc/dmlite.conf.d/vfs.conf":
      owner   => $user,
      group   => $group,
      mode    => 0600,
      content => template("dmlite/plugins/vfs.conf.erb"),
      require => Package["dmlite-plugins-vfs"]
  }
}
