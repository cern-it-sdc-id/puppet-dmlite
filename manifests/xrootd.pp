
class dmlite::xrootd (
  $nodetype = ['head', 'disk'], # head, disk
  $domain,
  $dmlite_conf = '/etc/dmlite.conf',
  $dpmhost = $::fqdn,
  $nshost = $::fqdn,
  $ns_basepath = $dmlite::dpm::config::basepath,
  $xrootd_use_voms = true,
  $xrootd_monitor = undef,
  $xrd_report = undef,
  $xrd_dpmclassic = false,
  $dpm_xrootd_debug = false,
  $dpm_xrootd_sharedkey = undef,
  $dpm_xrootd_serverport = 1095,
  $dpm_mmreqhost = 'localhost',
  $site_name = undef,
  $alice_token = false,
  $alice_token_conf = undef,
  $alice_token_libname = undef,
  $alice_token_principal = undef,
  $alice_fqans = undef,
  $dpm_xrootd_fedredirs = {},
  $log_style_param = '-k fifo', #'-k fifo' for xrootd4
  $vomsxrd_package = 'vomsxrd',
  $enable_hdfs = false,
) {

  validate_bool($xrootd_use_voms)
  validate_bool($xrd_dpmclassic)
  validate_bool($dpm_xrootd_debug)
  validate_bool($alice_token)

  Dmlite::Xrootd::Create_Config <| |> ~> Class[Xrootd::Service]
  Xrootd::Create_Sysconfig <| |> ~> Class[Xrootd::Service]
  Exec['delete .xrootd.log files'] ~> Class[Xrootd::Service]
  Exec['delete .xrootd.log files'] -> Xrootd::Create_sysconfig <| |>
  Class[Dmlite::Xrootd] ~> Class['Xrootd::Service']

  package {'dpm-xrootd':
    ensure => present
  }

  if $ns_basepath == undef {
    $domainpath = "/${lcgdm::ns::config::basepath}/${domain}"
  } else {
    $domainpath = "/${ns_basepath}/${domain}"
  }

  include xrootd::config
  include xrootd::service

  if $enable_hdfs {
    $java_home= $dmlite::plugins::hdfs::params::java_home
  }

  $sec_protocol_local = "/usr/${xrootd::config::xrdlibdir} unix"

  if $xrootd_use_voms == false and $xrd_dpmclassic == false {
    $dpm_listvoms = true
  }
  if $xrootd_use_voms == true and $xrd_dpmclassic == false {
    package{"${vomsxrd_package}":
      ensure => present
    }
  }

  if member($nodetype, 'disk') {

    if $xrootd_use_voms {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
    }

    if $xrd_dpmclassic == false {
      $ofs_tpc = 'pgm /usr/bin/xrdcp --server'
    }

    $xrootd_instances_options_disk = {
      'disk' => "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmdisk.cfg ${log_style_param}"
    }

    dmlite::xrootd::create_config{'/etc/xrootd/xrootd-dpmdisk.cfg':
      dmlite_conf    => $dmlite_conf,
      dpm_host       => $dpmhost,
      all_adminpath  => '/var/spool/xrootd',
      all_pidpath    => '/var/run/xrootd',
      all_sitename   => $site_name,
      xrd_allrole    => 'server',
      xrootd_seclib  => 'libXrdSec.so',
      xrootd_export  => [ '/' ],
      xrootd_async   => 'off',
      xrootd_monitor => $xrootd_monitor,
      ofs_authlib    => 'libXrdDPMDiskAcc.so.3',
      ofs_authorize  => true,
      xrd_ofsosslib  => 'libXrdDPMOss.so.3',
      ofs_persist    => 'auto hold 0',
      xrd_port       => $dpm_xrootd_serverport,
      xrd_network    => 'nodnr',
      xrd_report     => $xrd_report,
      xrd_debug      => $dpm_xrootd_debug,
      ofs_tpc        => $ofs_tpc,
      sec_protocol   => [ $sec_protocol_disk, $sec_protocol_local ],
      dpm_listvoms   => $dpm_listvoms,
      use_dmlite_io  => $enable_hdfs,
    }
  } else {
    $xrootd_instances_options_disk = {}
  }

  if member($nodetype, 'head') {

    if $xrootd_use_voms {

      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
    }

    $xrootd_instances_options_redir = {
      'redir' => "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmredir.cfg ${log_style_param}"
    }

    $ofs_authlib = 'libXrdDPMRedirAcc.so.3'

    dmlite::xrootd::create_config{'/etc/xrootd/xrootd-dpmredir.cfg':
      dmlite_conf           => $dmlite_conf,
      dpm_host              => $dpmhost,
      all_adminpath         => '/var/spool/xrootd',
      all_pidpath           => '/var/run/xrootd',
      all_sitename          => $site_name,
      xrd_allrole           => 'manager',
      xrootd_seclib         => 'libXrdSec.so',
      xrootd_export         => [ '/' ],
      xrootd_monitor        => $xrootd_monitor,
      ofs_authlib           => $ofs_authlib,
      ofs_authorize         => true,
      xrd_ofsosslib         => 'libXrdDPMOss.so.3',
      ofs_cmslib            => 'libXrdDPMFinder.so.3',
      ofs_forward           => 'all',
      xrd_network           => 'nodnr',
      xrd_report            => $xrd_report,
      xrd_debug             => $dpm_xrootd_debug,
      sec_protocol          => [ $sec_protocol_redir, $sec_protocol_local ],
      dpm_listvoms          => $dpm_listvoms,
      dpm_mmreqhost         => "${dpm_mmreqhost}",
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
      dmlite_conf           => $dmlite_conf,
      dpm_host              => $dpmhost,
      all_adminpath         => '/var/spool/xrootd',
      all_pidpath           => '/var/run/xrootd',
      all_sitename          => $site_name,
      xrd_allrole           => 'manager',
      cmsd_allrole          => 'server',
      xrootd_seclib         => 'libXrdSec.so',
      xrootd_monitor        => $xrootd_monitor,
      ofs_authlib           => $ofs_authlib,
      ofs_authorize         => true,
      xrd_ofsosslib         => 'libXrdDPMOss.so.3',
      cmsd_ofsosslib        => 'libXrdPss.so',
      pss_setopt            => [
        'ConnectTimeout 30',
        'RequestTimeout 30',
        'RedirectLimit 0'],
      ofs_cmslib            => 'libXrdDPMFinder.so.3',
      ofs_forward           => 'all',
      xrd_network           => 'nodnr',
      xrd_report            => $xrd_report,
      xrd_debug             => $dpm_xrootd_debug,
      sec_protocol          => [$sec_protocol_redir, $sec_protocol_local],
      dpm_listvoms          => $dpm_listvoms,
      dpm_mmreqhost         => "${dpm_mmreqhost}",
      dpm_xrootd_serverport => $dpm_xrootd_serverport,
      dpm_enablecmsclient   => true,
    }

    create_resources('dmlite::xrootd::create_redir_config', $dpm_xrootd_fedredirs, $federation_defaults)

    $xrootd_instances_options_fed = map_hash($dpm_xrootd_fedredirs, "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmfedredir_%s.cfg ${log_style_param}")
    $cmsd_instances_options_fed = map_hash($dpm_xrootd_fedredirs, "-l /var/log/xrootd/cmsd.log -c /etc/xrootd/xrootd-dpmfedredir_%s.cfg ${log_style_param}")

  } else {
    $xrootd_instances_options_redir = {}
    $xrootd_instances_options_fed = {}
    $cmsd_instances_options_fed = {}
  }

  $xrootd_instances_options_all = [
    $xrootd_instances_options_redir,
    $xrootd_instances_options_disk,
    $xrootd_instances_options_fed
  ]

  $exports = {
    'DPM_HOST'             => $dpmhost,
    'DPNS_HOST'            => $nshost,
    'DPM_CONRETRY'         => 0,
    'DPNS_CONRETRY'        => 0,
    'XRD_MAXREDIRECTCOUNT' => 1,
    'MALLOC_ARENA_MAX'     => 4
  }

  if $dpm_xrootd_debug {
    $daemon_corefile_limit = 'unlimited'
  }

  if ($log_style_param == '-k fifo') {  # delete all non-fifo files
    exec{'delete .xrootd.log files':
      command => '/bin/find /var/log/xrootd -type f -name .xrootd.log -exec rm {} \;',
      path    => '/bin/:/usr/bin/',
      unless  => '[ "`/bin/find /var/log/xrootd -type f -name .xrootd.log -type f`" = "" ]'
    }
  } else {  # do not use fifos, so delete all fifo files
    exec{'delete .xrootd.log files':
      command => '/bin/find /var/log/xrootd -type f -name .xrootd.log -exec rm {} \;',
      path    => '/bin/:/usr/bin/',
      unless  => '[ "`/bin/find /var/log/xrootd -type f -name .xrootd.log -type p`" = "" ]'
    }
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
  file{'/etc/xrootd/dpmxrd-sharedkey.dat':
    ensure  => file,
    owner   => $lcgdm::base::config::user,
    group   => $lcgdm::base::config::user,
    mode    => '0640',
    content => $dpm_xrootd_sharedkey
  }


  include xrootd::service

  file { '/var/log/xrootd/redir':
    ensure    => directory,
    owner     => $lcgdm::base::config::user,
    group     => $lcgdm::base::config::user,
    subscribe => [File['/var/log/xrootd']],
    require   => Class['xrootd::config'],
  }

  file { '/var/log/xrootd/disk':
    ensure    => directory,
    owner     => $lcgdm::base::config::user,
    group     => $lcgdm::base::config::user,
    subscribe => [File['/var/log/xrootd']],
    require   => Class['xrootd::config'],
  }

}
