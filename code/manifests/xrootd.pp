
class dmlite::xrootd (
  $nodetype = ["head", "disk"], # head, disk
  $domain,
  $dpmhost = $fqdn,
  $nshost = $fqdn,
  $ns_basepath = $dmlite::dpm::config::basepath,
  $xrootd_use_voms = true,
  $xrootd_monitor = undef,
  $xrd_report = undef,
  $xrd_dpmclassic = false,
  $dpm_xrootd_debug = false,
  $dpm_xrootd_sharedkey = undef,
  $dpm_xrootd_serverport = 1095,
  $site_name = undef,
  $alice_token = false,
  $alice_token_conf = undef,
  $alice_token_libname = undef,
  $alice_token_principal = undef,
  $alice_fqans = undef,
  $dpm_xrootd_fedredirs = {}
) {

  Dmlite::Xrootd::Create_Config <| |> ~> Class[Xrootd::Service]
  Xrootd::Create_Sysconfig <| |> ~> Class[Xrootd::Service]

  package {"dpm-xrootd":
    ensure => present
  }

  if $ns_basepath == undef {
    $domainpath = "/${lcgdm::ns::config::basepath}/${domain}"
  } else {
    $domainpath = "/${ns_basepath}/${domain}"
  }

  include xrootd::config
  include xrootd::service

  $sec_protocol_local = "/usr/${xrootd::config::xrdlibdir} unix"

  if $xootd_use_voms == false and $xrd_dpmclassic == false {
    $dpm_listvoms = true
  }
  if $xrootd_use_voms == true and $xrd_dpmclassic == false {
    package{"vomsxrd":
      ensure => present
    }
  }

  if member($nodetype, "disk") {

    if $xrootd_use_voms {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
    }

    if $xrd_dpmclassic == "" {
      $ofs_tpc = "pgm /usr/bin/xrdcp --server"
    }

    $xrootd_instances_options_disk = {
      "disk" => "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmdisk.cfg"
    }

    dmlite::xrootd::create_config{"/etc/xrootd/xrootd-dpmdisk.cfg":
      dpm_host       => $dpmhost,
      all_adminpath  => "/var/spool/xrootd",
      all_pidpath    => "/var/run/xrootd",
      all_sitename   => $site_name,
      xrd_allrole    => "server",
      xrootd_seclib  => "libXrdSec.so",
      xrootd_export  => [ "/" ],
      xrootd_async   => "off",
      xrootd_monitor => $xrootd_monitor,
      ofs_authlib    => "libXrdDPMDiskAcc.so.3",
      ofs_authorize  => true,
      xrd_ofsosslib  => "libXrdDPMOss.so.3",
      ofs_persist    => "auto hold 0",
      xrd_port       => $dpm_xrootd_serverport,
      xrd_network    => "nodnr",
      xrd_report     => $xrd_report,
      xrd_debug      => $dpm_xrootd_debug,
      ofs_tpc        => $ofs_tpc,
      sec_protocol   => [ $sec_protocol_disk, $sec_protocol_local ],
      dpm_listvoms   => $dpm_listvoms
    }
  } else {
    $xrootd_instances_options_disk = {}
  }

  if member($nodetype, "head") {

    if $xrootd_use_voms {

      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
    }

    $xrootd_instances_options_redir = {
      "redir" => "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmredir.cfg"
    }

    $ofs_authlib = "libXrdDPMRedirAcc.so.3"

    dmlite::xrootd::create_config{"/etc/xrootd/xrootd-dpmredir.cfg":
      dpm_host              => $dpmhost,
      all_adminpath         => "/var/spool/xrootd",
      all_pidpath           => "/var/run/xrootd",
      all_sitename          => $site_name,
      xrd_allrole           => "manager",
      xrootd_seclib         => "libXrdSec.so",
      xrootd_export         => [ "/" ],
      xrootd_monitor        => $xrootd_monitor,
      ofs_authlib           => $ofs_authlib,
      ofs_authorize         => true,
      xrd_ofsosslib         => "libXrdDPMOss.so.3",
      ofs_cmslib            => "libXrdDPMFinder.so.3",
      ofs_forward           => "all",
      xrd_network           => "nodnr",
      xrd_report            => $xrd_report,
      xrd_debug             => $dpm_xrootd_debug,
      sec_protocol          => [ $sec_protocol_redir, $sec_protocol_local ],
      dpm_listvoms          => $dpm_listvoms,
      dpm_defaultprefix     => "${domainpath}/home",
      dpm_xrootd_serverport => $dpm_xrootd_serverport,
      domainpath            => $domainpath,
      alice_token           => $alice_token,
      alice_token_conf      => $alice_token_conf,
      alice_token_principal => $alice_token_principal,
      alice_token_libname   => $alice_token_libname,
      alice_fqans           => $alice_fqans,
      dpm_xrootd_fedredirs  => $dpm_xrootd_fedredirs

    }

    $federation_defaults = {
      dpm_host              => $dpmhost,
      all_adminpath         => "/var/spool/xrootd", #
      all_pidpath           => "/var/run/xrootd", #
      all_sitename          => $site_name, #
      xrd_allrole           => "manager",
      cmsd_allrole          => "server",
      xrootd_seclib         => "libXrdSec.so",
      xrootd_monitor        => $xrootd_monitor,
      #xrootd_export        => [ "/" ],
      ofs_authlib           => $ofs_authlib,
      ofs_authorize         => true,
      xrd_ofsosslib         => "libXrdDPMOss.so.3",
      cmsd_ofsosslib        => "libXrdPss.so",
      pss_setopt            => [ "ConnectTimeout 30",
                                 "RequestTimeout 30" ],
      ofs_cmslib            => "libXrdDPMFinder.so.3",
      ofs_forward           => "all",
      xrd_network           => "nodnr", #
      xrd_report            => $xrd_report,
      xrd_debug             => $dpm_xrootd_debug, #
      sec_protocol          => [ $sec_protocol_redir ],
      dpm_listvoms          => $dpm_listvoms,
      #dpm_defaultprefix     => "${domainpath}/home",
      dpm_xrootd_serverport => $dpm_xrootd_serverport
    }

    create_resources('dmlite::xrootd::create_redir_config', $dpm_xrootd_fedredirs, $federation_defaults)

    $xrootd_instances_options_fed = map_hash($dpm_xrootd_fedredirs, "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmfedredir_%s.cfg")
    $cmsd_instances_options_fed = map_hash($dpm_xrootd_fedredirs, "-l /var/log/xrootd/cmsd.log -c /etc/xrootd/xrootd-dpmfedredir_%s.cfg")

  } else {
    $xrootd_instances_options_redir = {}
    $xrootd_instances_options_fed = {}
    $cmsd_instances_options_fed = {}
  }

  $xrootd_instances_options_all = merge(
    $xrootd_instances_options_disk,
    $xrootd_instances_options_redir,
    $xrootd_instances_options_fed
  )

  $exports = { "DPM_HOST"             => $dpmhost,
               "DPNS_HOST"            => $nshost,
               "DPM_CONRETRY"         => 0,
               "DPNS_CONRETRY"        => 0,
               "XRD_MAXREDIRECTCOUNT" => 1
  }

  if $dpm_xrootd_debug {
    $daemon_corefile_limit = "unlimited"
  }

  xrootd::create_sysconfig{$xrootd::config::sysconfigfile:
    xrootd_user              => $lcgdm::base::config::user,
    xrootd_group             => $lcgdm::base::config::user,
    xrootd_instances_options => $xrootd_instances_options_all,
    cmsd_instances_options   => $cmsd_instances_options_fed,
    exports                  => $exports,
    daemon_corefile_limit    => $daemon_corefile_limit
  }

  # TODO: make the basedir point to $xrootd::config::configdir
  file{"/etc/xrootd/dpmxrd-sharedkey.dat":
    ensure  => file,
    owner   => $lcgdm::base::config::user,
    group   => $lcgdm::base::config::user,
    mode    => 0640,
    content => $dpm_xrootd_sharedkey
  }


  include xrootd::install
  include xrootd::service
}
