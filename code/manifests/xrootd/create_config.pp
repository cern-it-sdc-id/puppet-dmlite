define dmlite::xrootd::create_config (
  $filename = $title,
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

  $ofs_authlib = $xrootd::config::ofs_authlib,
  $ofs_authorize = $xrootd::config::ofs_authorize,
  $ofs_persist = $xrootd::config::ofs_persist,
  # ofs.osslib for exec xrootd/cmsd
  $xrd_ofsosslib = $xrootd::config::xrd_ofsosslib,
  $cmsd_ofsosslib = $xrootd::config::cmsd_ofsosslib,
  $ofs_cmslib = $xrootd::config::ofs_cmslib,
  $ofs_forward = $xrootd::config::ofs_forward,
  $ofs_tpc = $xrootd::config::ofs_tpc,

  $sec_protocol = $xrootd::config::sec_protocol,

  $pss_origin = $xrootd::config::pss_origin,

  $dpm_listvoms = undef,
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

  $dpm_xrootd_fedredirs = undef

) {
  include xrootd::config

  validate_bool($xrd_debug)
  if $alice_token {
    validate_bool($alice_token)
  }

  file {"$filename":
    ensure  => file,
    owner  => $xrootd::config::xrootd_user,
    group  => $xrootd::config::xrootd_group,
    content => template($xrootd::config::configfile_template,
                        "dmlite/xrootd/dpm-xrootd.cfg.erb")
  }

}
