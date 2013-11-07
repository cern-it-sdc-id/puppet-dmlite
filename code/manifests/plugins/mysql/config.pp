class dmlite::plugins::mysql::config (
  $mysql_host       = $dmlite::plugins::mysql::params::mysql_host,
  $mysql_username   = $dmlite::plugins::mysql::params::mysql_username,
  $mysql_password,
  $mysql_port       = $dmlite::plugins::mysql::params::mysql_port,
  $ns_db            = $dmlite::plugins::mysql::params::ns_db,
  $dpm_db           = $dmlite::plugins::mysql::params::dpm_db,
  $dbpool_size      = $dmlite::plugins::mysql::params::dbpool_size,
  $mapfile          = $dmlite::plugins::mysql::params::mapfile,
  $host_dn_is_root  = $dmlite::plugins::mysql::params::host_dn_is_root,
  $enable_dpm       = $dmlite::plugins::mysql::params::enable_dpm,
  $enable_ns        = $dmlite::plugins::mysql::params::enable_ns,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group
) inherits dmlite::plugins::mysql::params {

    file {
      "/etc/dmlite.conf.d/mysql.conf":
        owner   => $user,
        group   => $group,
        mode    => 0600,
        content => template("dmlite/plugins/mysql.conf.erb"),
        require => Package["dmlite-plugins-mysql"]
    }
}
