class dmlite::plugins::mysql::params (
) inherits dmlite::params {
    $mysql_host		= "localhost"
    $mysql_username	= "dpmdbuser"
    $mysql_password	= "change-this"
    $mysql_port		= 0
    $ns_db		= "cns_db"
    $dpm_db		= "dpm_db"
    $dbpool_size	= 100
    $mapfile		= "/etc/lcgdm-mapfile"
    $host_dn_is_root	= "no"

    $enable_dpm		= true
    $enable_ns		= false
}
