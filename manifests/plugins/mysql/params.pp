class dmlite::plugins::mysql::params (
) inherits dmlite::params {
    $mysql_host       = hiera('dmlite::plugins::mysql::params::mysql_host',      'localhost')
    $mysql_username   = hiera('dmlite::plugins::mysql::params::mysql_username',  'dpmdbuser')
    $mysql_port       = hiera('dmlite::plugins::mysql::params::mysql_port',      0)
    $mysql_dir_space_report_depth = hiera('dmlite::plugins::mysql::params::mysql_dir_space_report_depth',      6)
    $ns_db            = hiera('dmlite::plugins::mysql::params::ns_db',           'cns_db')
    $dpm_db           = hiera('dmlite::plugins::mysql::params::dpm_db',          'dpm_db')
    $dbpool_size      = hiera('dmlite::plugins::mysql::params::dbpool_size',     128)
    $mapfile          = hiera('dmlite::plugins::mysql::params::mapfile',         '/etc/lcgdm-mapfile')
    $host_dn_is_root  = hiera('dmlite::plugins::mysql::params::host_dn_is_root', 'yes')
    $host_cert        = hiera('dmlite::plugins::mysql::params::host_cert', '')
    $enable_dpm       = hiera('dmlite::plugins::mysql::params::enable_dpm',      true)
    $enable_ns        = hiera('dmlite::plugins::mysql::params::enable_ns',       true)
    $enable_io        = hiera('dmlite::plugins::mysql::params::enable_io',       false)
}
