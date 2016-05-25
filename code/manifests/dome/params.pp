class dmlite::dome::params (
) inherits dmlite::params {
    $head_port     	= 9001
    $disk_port		= 9002
    $head       	= false
    $disk   	        = true
    $head_debug		= 4
    $disk_debug 	= 4
    $head_maxcallouts   = 3
    $head_maxcalloutspernode = 2
    $head_maxchecksums  = 3
    $head_maxchecksumspernode  = 2
    $db_host 		= 'localhost'
    $db_user  		= undef
    $db_password	= undef
    $db_port		= 0
    $db_pool_size	= 10
    $head_task_maxrunningtime = 3600
    $head_task_purgetime = 3600
    $disk_task_maxrunningtime = 3600
    $disk_task_purgetime = 3600
    $put_minfreespace_mb = 1
    $head_auth_authorizeDN = []
    $disk_auth_authorizeDN = []
    $dirspacereportdepth = 6
    $restclient_cli_certificate = '/etc/grid-security/dpmmgr/dpmcert.pem'
    $restclient_cli_private_key = '/etc/grid-security/dpmmgr/dpmkey.pem'
    $head_filepuller_stathook = undef
    $disk_filepuller_pullhook = undef
    $filepuller = undef
    $headnode_domeurl = undef
    
}
