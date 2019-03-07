class dmlite::dome::params (
) inherits dmlite::params {
    $head       	= false
    $disk   	        = true
    $head_debug		= hiera('dmlite::dome::params::head_debug', 1)
    $disk_debug 	= hiera('dmlite::dome::params::disk_debug', 1)
    $head_maxfilepulls   = hiera('dmlite::dome::params::head_maxfilepulls', 1000)
    $head_maxfilepullspernode =  hiera('dmlite::dome::params::head_maxfilepullspernode', 40)
    $head_checksum_maxtotal = hiera('dmlite::dome::params::head_checksum_maxtotal', 1000)
    $head_checksum_maxpernode = hiera('dmlite::dome::params::head_checksum_maxpernode', 40)
    $db_host 		= hiera('dmlite::dome::params::db_host', 'localhost')
    $db_user  		= hiera('dmlite::dome::params::db_user', 'dpmmgr')
    $db_password	= undef
    $db_port		= hiera('dmlite::dome::params::db_port', 0)
    $db_pool_size	= hiera('dmlite::dome::params::db_pool_size', 128)
    $cnsdb_name         = hiera('dmlite::dome::params::cnsdb_name', 'cns_db')
    $dpmdb_name         = hiera('dmlite::dome::params::dpmdb_name', 'dpm_db')
    $head_task_maxrunningtime = hiera('dmlite::dome::params::head_task_maxrunningtime', 3600)
    $head_task_purgetime = hiera('dmlite::dome::params::head_task_purgetime', 3600)
    $disk_task_maxrunningtime = hiera('dmlite::dome::params::disk_task_maxrunningtime', 3600)
    $disk_task_purgetime = hiera('dmlite::dome::params::disk_task_purgetime', 3600)
    $put_minfreespace_mb = hiera('dmlite::dome::params::put_minfreespace_mb', 1)
    $head_auth_authorizeDN = hiera('dmlite::dome::params::head_auth_authorizeDN', [])
    $disk_auth_authorizeDN = hiera('dmlite::dome::params::disk_auth_authorizeDN', [])
    $dirspacereportdepth = hiera('dmlite::dome::params::dirspacereportdepth', 6)
    $restclient_cli_certificate = hiera('dmlite::dome::params::restclient_cli_certificate','/etc/grid-security/dpmmgr/dpmcert.pem')
    $restclient_cli_private_key = hiera('dmlite::dome::params::restclient_cli_private_key','/etc/grid-security/dpmmgr/dpmkey.pem')
    $head_filepuller_stathook = hiera('dmlite::dome::params::head_filepuller_stathook','/usr/share/dmlite/filepull/externalstat_example.sh')
    $head_filepuller_stathooktimeout = hiera('dmlite::dome::params::head_filepuller_stathooktimeout',0)
    $disk_filepuller_pullhook = hiera('dmlite::dome::params::disk_filepuller_pullhook','/usr/share/dmlite/filepull/externalpull_example.sh')
    $filepuller = undef
    $headnode_domeurl = hiera('dmlite::dome::params::headnode_domeurl',undef)
    $proxy_timeout = hiera('dmlite::dome::params::proxy_timeout',600)
    $restclient_cli_xrdhttpkey = hiera('mlite::dome::params::restclient_cli_xrdhttpkey',undef)
}
