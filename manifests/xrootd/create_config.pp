define dmlite::xrootd::create_config (
  $filename = $title,
  $dmlite_conf = undef,
  $dpm_host = $fqdn,

  $xrootd_user = $xrootd::config::xrootd_user,
  $xrootd_group = $xrootd::config::xrootd_group,

  $configdir = $xrootd::config::configdir,

  # sets 'daemon.trace all' for ofs,xrd,cms,oss
  $xrd_debug = $xrootd::config::xrd_debug,

  $all_adminpath = $xrootd::config::all_adminpath,
  $all_pidpath = $xrootd::config::all_pidpath,
  # all.role for exec xrootd/cmsd
  $xrd_allrole = $xrootd::config::xrd_allrole,
  $cmsd_allrole = $xrootd::config::cmsd_allrole,
  $all_export = $xrootd::config::all_export,
  $all_manager = $xrootd::config::all_manager,
  $all_sitename = $xrootd::config::all_sitename,

  $xrootd_redirect = $xrootd::config::xrootd_redirect,
  $xrootd_export = $xrootd::config::xrootd_export,
  $xrootd_seclib = $xrootd::config::xrootd_seclib,
  $xrootd_async = $xrootd::config::xrootd_async,

  $xrd_port = $xrootd::config::xrd_port,
  $xrd_network = $xrootd::config::xrd_network,
  $xrd_report = $xrootd::config::xrd_report,
  $xrootd_monitor = $xrootd::config::xrootd_monitor,
  $xrootd_chksum = $xrootd::config::xrootd_chksum,
  $ofs_authlib = $xrootd::config::ofs_authlib,
  $ofs_authorize = $xrootd::config::ofs_authorize,
  $ofs_persist = $xrootd::config::ofs_persist,
  # ofs.osslib for exec xrootd/cmsd
  $xrd_ofsosslib = $xrootd::config::xrd_ofsosslib,
  $cmsd_ofsosslib = $xrootd::config::cmsd_ofsosslib,
  $ofs_cmslib = $xrootd::config::ofs_cmslib,
  $ofs_forward = $xrootd::config::ofs_forward,
  $ofs_tpc = $xrootd::config::ofs_tpc,
  $xrd_ofsckslib = undef,
  $sec_protocol = $xrootd::config::sec_protocol,

  $pss_origin = $xrootd::config::pss_origin,

  $dpm_listvoms = undef,
  $dpm_mmreqhost = undef,
  $dpm_defaultprefix = undef,
  $dpm_xrootd_serverport = undef,
  $dpm_enablecmsclient = undef,
  $dpm_namelib = undef,
  $dpm_replacementprefix = undef,

  $domainpath = undef,
  $alice_token = undef,
  $alice_token_conf = undef,
  $alice_token_principal = undef,
  $alice_token_libname = undef,
  $alice_fqans = undef,

  $dpm_xrootd_fedredirs = undef,
  $use_dmlite_io = false,
  $dpm_enable_dome = false,
  $dpm_xrdhttp_secret_key = undef,
  $dpm_dome_conf_file = undef,
  $dpm_xrdhttp_cipher_list = 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256',
) {
  include xrootd::config

  validate_bool($xrd_debug)
  if $alice_token {
    validate_bool($alice_token)
  }

  file { "${filename}":
    ensure  => file,
    owner   => $xrootd::config::xrootd_user,
    group   => $xrootd::config::xrootd_group,
    content => template($xrootd::config::configfile_template, 'dmlite/xrootd/dpm-xrootd.cfg.erb'
    )
  }

}
