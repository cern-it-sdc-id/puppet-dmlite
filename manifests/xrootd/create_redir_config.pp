define dmlite::xrootd::create_redir_config (
  $fedname = $title,
  $dmlite_conf = undef,
  $fed_host = undef,
  $xrootd_port = undef,
  $cmsd_port = undef,
  $local_port = undef,
  $paths = undef,

  $namelib_prefix = undef,
  $namelib = undef,
  $setenv = undef,

  $dpm_host = $::fqdn,

  $xrootd_user = $xrootd::config::xrootd_user,
  $xrootd_group = $xrootd::config::xrootd_group,

  # sets 'daemon.trace all' for ofs,xrd,cms,oss
  $xrd_debug = $xrootd::config::xrd_debug,

  $all_adminpath = $xrootd::config::all_adminpath,
  $all_pidpath = $xrootd::config::all_pidpath,
  # all.role for exec xrootd/cmsd
  $xrd_allrole = $xrootd::config::xrd_allrole,
  $cmsd_allrole = $xrootd::config::cmsd_allrole,
  $all_sitename = $xrootd::config::all_sitename,

  $xrootd_seclib = $xrootd::config::xrootd_seclib,

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

  $pss_setopt = $xrootd::config::pss_setopt,
  $cms_cidtag =  $xrootd::config::cms_cidtag,
  $oss_statlib = $xrootd::config::oss_statlib,

  $dpm_listvoms = undef,
  $dpm_mmreqhost = undef,
  $dpm_defaultprefix = undef,
  $dpm_xrootd_serverport = undef,
  $dpm_enablecmsclient = undef,
  $dpm_replacementprefix = undef

) {
  include xrootd::config

  $filename = "${xrootd::config::configdir}/xrootd-dpmfedredir_${title}.cfg"

  # constructing variables from the parameters
  $pss_origin = "localhost:${local_port}"
  $xrd_port = $local_port
  $all_manager = "${fed_host}+:${cmsd_port}"
  $all_export = $paths

  $dpm_namelib = $namelib
  $dpm_namecheck = $namelib_prefix

  file { "${filename}":
    ensure  => file,
    owner   => $xrootd::config::xrootd_user,
    group   => $xrootd::config::xrootd_group,
    content => template($xrootd::config::configfile_template, 'dmlite/xrootd/dpm-xrootd.cfg.erb'
    )
  }

}
