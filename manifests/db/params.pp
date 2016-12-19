class dmlite::db::params ()  inherits dmlite::db {
  $host     = "${::fqdn}"
  $nshost   = "${::fqdn}"
  $dbflavor = 'mysql'
  $dbhost   = 'localhost'
  $dpm_db   = 'dpm_db'
  $ns_db    = 'cns_db'
  $dbmanage = true
  $active   = 'yes'
}
