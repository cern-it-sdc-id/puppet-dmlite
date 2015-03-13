class dmlite::plugins::oracle::config (
    $oracle_username	= $dmlite::plugins::oracle::params::oracle_username,
    $oracle_password	= $dmlite::plugins::oracle::params::oracle_password,
    $oracle_db		= $dmlite::plugins::oracle::params::oracle_db,
    $dbpool_min		= $dmlite::plugins::oracle::params::dbpool_min,
    $dbpool_max		= $dmlite::plugins::oracle::params::dbpool_max,
    $mapfile		= $dmlite::plugins::oracle::params::mapfile,
    $host_dn_is_root	= $dmlite::plugins::oracle::params::host_dn_is_root,
    $enable_ns		= $dmlite::plugins::oracle::params::enable_ns
    $user               = $dmlite::params::user,
    $group              = $dmlite::params::group
) inherits dmlite::plugins::oracle::params {

    file {
      "/etc/dmlite.conf.d/oracle.conf":
        owner   => $user,
        group   => $group,
        mode    => 0600,
        content => template("dmlite/plugins/oracle.conf.erb"),
        require => Package["dmlite-plugins-oracle"]
    }
}

