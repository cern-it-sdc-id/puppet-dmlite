class dmlite::dome::config (
  $dome_head	      = $dmlite::dome::params::head,
  $dome_disk          = $dmlite::dome::params::disk,
  $head_debug         = $dmlite::dome::params::head_debug,
  $disk_debug         = $dmlite::dome::params::disk_debug,
  $head_maxcallouts   = $dmlite::dome::params::head_maxcallouts,
  $head_maxcalloutspernode = $dmlite::dome::params::head_maxcalloutspernode,
  $head_maxchecksums  = $dmlite::dome::params::head_maxchecksums,
  $head_maxchecksumspernode  = $dmlite::dome::params::head_maxchecksumspernode,
  $db_host            = $dmlite::dome::params::db_host,
  $db_user	      = $dmlite::dome::params::db_user,
  $db_password	      = undef,
  $db_port            = $dmlite::dome::params::db_port,
  $db_pool_size        = $dmlite::dome::params::db_pool_size,
  $head_task_maxrunningtime = $dmlite::dome::params::head_task_maxrunningtime,
  $head_task_purgetime = $dmlite::dome::params::head_task_purgetime,
  $disk_task_maxrunningtime = $dmlite::dome::params::disk_task_maxrunningtime,
  $disk_task_purgetime = $dmlite::dome::params::disk_task_purgetime,
  $put_minfreespace_mb = $dmlite::dome::params::put_minfreespace_mb,
  $head_auth_authorizeDN = $dmlite::dome::params::head_auth_authorizeDN,
  $disk_auth_authorizeDN = $dmlite::dome::params::disk_auth_authorizeDN,
  $dirspacereportdepth = $dmlite::dome::params::dirspacereportdepth,
  $restclient_cli_certificate = $dmlite::dome::params::restclient_cli_certificate,
  $restclient_cli_private_key = $dmlite::dome::params::restclient_cli_private_key,
  $head_filepuller_stathook = $dmlite::dome::params::head_filepuller_stathook,
  $head_filepuller_stathooktimeout = $dmlite::dome::params::head_filepuller_stathooktimeout,
  $disk_filepuller_pullhook = $dmlite::dome::params::disk_filepuller_pullhook,
  $filepuller = undef,
  $headnode_domeurl = $dmlite::dome::params::headnode_domeurl,
  $proxy_timeout = $dmlite::dome::params::proxy_timeout,
  $restclient_cli_xrdhttpkey = $dmlite::dome::params::restclient_cli_xrdhttpkey,
) inherits dmlite::dome::params {

  validate_bool($dome_head)
  validate_bool($dome_disk)

  $domehead_template = 'dmlite/dome/domehead.conf.erb'
  $domedisk_template = 'dmlite/dome/domedisk.conf.erb'

  file {
    '/etc/httpd/conf.d/zdome.conf':
      ensure  => absent,
  }


  Class[dmlite::dome::install] -> Class[dmlite::dome::config]

  if $dome_head {
  	file {
	    '/etc/domehead.conf':
	      ensure  => present,
	      content => template("${domehead_template}");
	  }
  }

  if $dome_disk {
        file {
            '/etc/domedisk.conf':
              ensure  => present,
              content => template("${domedisk_template}");
          }
  }

}
