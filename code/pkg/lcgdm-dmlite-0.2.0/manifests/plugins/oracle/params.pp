class dmlite::plugins::oracle::params (
) inherits dmlite::params {
    $oracle_username	= "dpmdbuser"
    $oracle_password	= "change-this"
    $oracle_db		= "localhost"
    $dbpool_min		= 8
    $dbpool_max		= 32
    $mapfile		= "/etc/lcgdm-mapfile"
    $host_dn_is_root	= "no"

    $enable_ns		= true
}
