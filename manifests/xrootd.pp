
class dmlite::xrootd (
  $nodetype = ['head', 'disk'], # head, disk
  $domain,
  $dmlite_conf = '/etc/dmlite.conf',
  $dpmhost = $::fqdn,
  $nshost = $::fqdn,
  $ns_basepath = 'dpm',
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
  $lcgdm_user = 'dpmmgr',
  $legacy = true,
  $dpm_enable_dome = false,
  $dpm_xrdhttp_secret_key = '',
  $after_conf_head = 'network-online.target mariadb.service',
  $after_conf_disk = 'network-online.target',
  $runtime_dir = 'dpmxrootd'
) {

  validate_bool($xrootd_use_voms)
  validate_bool($xrd_dpmclassic)
  validate_bool($dpm_xrootd_debug)
  validate_bool($alice_token)

  Dmlite::Xrootd::Create_config <| |> ~> Class[xrootd::service]
  Xrootd::Create_sysconfig <| |> ~> Class[xrootd::service]
  Exec['delete .xrootd.log files'] ~> Class[xrootd::service]
  Exec['delete .xrootd.log files'] -> Xrootd::Create_sysconfig <| |>
  Class[dmlite::xrootd] ~> Class['xrootd::service']
  if $legacy {
    Class[lcgdm::base::config] -> Class[dmlite::xrootd] 
  } else {
     Class[dmlite::base::config] -> Class[dmlite::xrootd]
  }
  package {'dpm-xrootd':
    ensure => present
  }

  $domainpath = "/${ns_basepath}/${domain}"

  include xrootd::config

  if $enable_hdfs {
    include dmlite::plugins::hdfs::params
    $java_home= $dmlite::plugins::hdfs::params::java_home
  } else {
    $java_home= undef
  }

  $sec_protocol_local = "/usr/${xrootd::config::xrdlibdir} unix"

  if $xrootd_use_voms == false and $xrd_dpmclassic == false {
    $dpm_listvoms = true
  }
  else {
    $dpm_listvoms = false
  }
  if $xrootd_use_voms == true and $xrd_dpmclassic == false {
    package{"${vomsxrd_package}":
      ensure => present
    }
  }

  if member($nodetype, 'disk') {

    if $xrootd_use_voms {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm_user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm_user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm_user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm_user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
    }

    if $xrd_dpmclassic == false {
      $ofs_tpc = 'pgm /usr/bin/xrdcp --server'
    }

    $xrootd_instances_options_disk = {
      'disk' => "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmdisk.cfg ${log_style_param}"
    }

    dmlite::xrootd::create_config{'/etc/xrootd/xrootd-dpmdisk.cfg':
      dmlite_conf            => $dmlite_conf,
      dpm_host               => $dpmhost,
      all_adminpath          => '/var/spool/xrootd',
      all_pidpath            => '/var/run/xrootd',
      all_sitename           => $site_name,
      xrd_allrole            => 'server',
      xrootd_seclib          => 'libXrdSec.so',
      xrootd_export          => [ '/' ],
      xrootd_async           => 'on',
      xrootd_monitor         => $xrootd_monitor,
      ofs_authlib            => 'libXrdDPMDiskAcc.so.3',
      ofs_authorize          => true,
      xrd_ofsosslib          => 'libXrdDPMOss.so.3',
      xrd_port               => $dpm_xrootd_serverport,
      xrd_network            => 'nodnr',
      xrd_report             => $xrd_report,
      xrd_debug              => $dpm_xrootd_debug,
      ofs_tpc                => $ofs_tpc,
      sec_protocol           => [ $sec_protocol_disk, $sec_protocol_local ],
      dpm_listvoms           => $dpm_listvoms,
      use_dmlite_io          => $enable_hdfs,
      dpm_enable_dome        => $dpm_enable_dome,
      dpm_xrdhttp_secret_key => $dpm_xrdhttp_secret_key,
      dpm_dome_conf_file     => '/etc/domedisk.conf'   
    }
  } else {
    $xrootd_instances_options_disk = {}
  }

  if member($nodetype, 'head') {

    if $xrootd_use_voms {

      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm_user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm_user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm_user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm_user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
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
      dpm_xrootd_fedredirs  => $dpm_xrootd_fedredirs,
      dpm_enable_dome       => $dpm_enable_dome,
      dpm_xrdhttp_secret_key => $dpm_xrdhttp_secret_key,
      dpm_dome_conf_file    => '/etc/domehead.conf'
   }
    $l = size("${::fqdn}")
    if $l > 16 {
	    $cms_cidtag = regsubst("${::fqdn}", '^(.{16})(.*)', '\1')
    } else {
	    $cms_cidtag = "${::fqdn}"
    }
    #retrieving xrootd version and apply conf

    if  versioncmp("${::package_dpm_xrootd}", '3.6.0') >= 0 {
	    $oss_statlib = '-2 libXrdDPMStatInfo.so.3'
    } else {
	    $oss_statlib = undef
    }
    $federation_defaults = {
      dmlite_conf           => $dmlite_conf,
      dpm_host              => $dpmhost,
      all_adminpath         => '/var/spool/xrootd',
      all_pidpath           => '/var/run/xrootd',
      all_sitename          => $site_name,
      cms_cidtag            => $cms_cidtag,
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
      oss_statlib           => $oss_statlib,
    }

    create_resources('dmlite::xrootd::create_redir_config', $dpm_xrootd_fedredirs, $federation_defaults)

    #added atlas digauth file
    $array_feds =  keys($dpm_xrootd_fedredirs)
    if member($array_feds, 'atlas') {
        $digauth_filename = '/etc/xrootd/digauth_atlas.cf'
        xrootd::create_digauthfile{$digauth_filename:
                host    => 'atlint04.slac.stanford.edu',
                group   => '/atlas',
        }

    }


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
  } else {
    $daemon_corefile_limit = undef
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

  #use syconfig in SL6, systemd otherwise

  if $::operatingsystemmajrelease and ($::operatingsystemmajrelease + 0) >= 7 {

        if member($nodetype, 'disk') {

                xrootd::create_systemd{"xrootd@dpmdisk":
                    xrootd_user              => $lcgdm_user,
                    xrootd_group             => $lcgdm_user,
                    exports                  => $exports,
                    daemon_corefile_limit    => $daemon_corefile_limit,
                    after_conf               => $after_conf_disk,
                    runtime_dir              => $runtime_dir
                }
        }

	if member($nodetype, 'head') {
		 #get federation hashes
	         $array_fed =  keys($dpm_xrootd_fedredirs)

		 if size($array_fed) > 0 {
	        	 $array_fed_final =  prefix($array_fed,'dpmfedredir_')
			 $xrootd_instances = flatten (concat (['dpmredir'],$array_fed_final))
  			 $cmsd_instances_final = prefix($array_fed_final,'cmsd@')
		 }
		 else {
			$xrootd_instances = ['dpmredir']
		 }
		 $xrootd_instances_final = prefix($xrootd_instances,'xrootd@')

                 dmlite::xrootd::create_systemd_config{ $xrootd_instances_final:
		 	xrootd_user              => $lcgdm_user,
		        xrootd_group             => $lcgdm_user,
		        exports                  => $exports,
		        daemon_corefile_limit    => $daemon_corefile_limit,
			after_conf               => $after_conf_head,
			runtime_dir              => $runtime_dir
		 }
		 if size($array_fed) > 0 {
		 	dmlite::xrootd::create_systemd_config{ $cmsd_instances_final:
                        	xrootd_user              => $lcgdm_user,
	                        xrootd_group             => $lcgdm_user,
        	                exports                  => $exports,
                	        daemon_corefile_limit    => $daemon_corefile_limit,
				after_conf               => $after_conf_head,
				runtime_dir              => $runtime_dir
	                 }
		 }


	}

  } else {

        xrootd::create_sysconfig{$xrootd::config::sysconfigfile:
            xrootd_user              => $lcgdm_user,
            xrootd_group             => $lcgdm_user,
            xrootd_instances_options => $xrootd_instances_options_all,
            cmsd_instances_options   => $cmsd_instances_options_fed,
            exports                  => $exports,
            daemon_corefile_limit    => $daemon_corefile_limit,
            enable_hdfs              => $enable_hdfs,
            java_home                => $java_home,
          }
  }

  # TODO: make the basedir point to $xrootd::config::configdir
  file{'/etc/xrootd/dpmxrd-sharedkey.dat':
    ensure  => file,
    owner   => $lcgdm_user,
    group   => $lcgdm_user,
    mode    => '0640',
    content => $dpm_xrootd_sharedkey
  }

  if $::operatingsystemmajrelease and ($::operatingsystemmajrelease + 0) >= 7 {

	 if member($nodetype, 'head') and  member($nodetype, 'disk') {
		class{'xrootd::service':
		    xrootd_instances  =>  concat (['xrootd@dpmdisk'],$xrootd_instances_final),
		    cmsd_instances => $cmsd_instances_final,
                    certificate => "/etc/grid-security/${lcgdm_user}/dpmcert.pem",
                    key  => "/etc/grid-security/${lcgdm_user}/dpmkey.pem",
	        }

	 } elsif member($nodetype, 'head') {
		class{'xrootd::service':
                    xrootd_instances  =>  $xrootd_instances_final,
                    cmsd_instances => $cmsd_instances_final,
		    certificate => "/etc/grid-security/${lcgdm_user}/dpmcert.pem",
                    key  => "/etc/grid-security/${lcgdm_user}/dpmkey.pem",
                 }

	 } else {
		class{'xrootd::service':
                    xrootd_instances  =>  ['xrootd@dpmdisk'],
		    certificate => "/etc/grid-security/${lcgdm_user}/dpmcert.pem",
                    key  => "/etc/grid-security/${lcgdm_user}/dpmkey.pem",
                }
	}
  }
  else {
	class{'xrootd::service':
	      certificate => "/etc/grid-security/${lcgdm_user}/dpmcert.pem",
              key  => "/etc/grid-security/${lcgdm_user}/dpmkey.pem",
	}
  }

  file { '/var/log/xrootd/redir':
    ensure    => directory,
    owner     => $lcgdm_user,
    group     => $lcgdm_user,
    subscribe => [File['/var/log/xrootd']],
    require   => Class['xrootd::config'],
  }

  file { '/var/log/xrootd/disk':
    ensure    => directory,
    owner     => $lcgdm_user,
    group     => $lcgdm_user,
    subscribe => [File['/var/log/xrootd']],
    require   => Class['xrootd::config'],
  }

}
