define dmlite::xrootd::create_systemd_config (
	$name= $title,
	$xrootd_user = undef,
        $xrootd_group = undef,
        $exports = undef,
        $daemon_corefile_limit  = undef,

) {
    xrootd::create_systemd{$name:
            xrootd_user              => $xrootd_user,
            xrootd_group             => $xrootd_group,
            exports                  => $exports,
            daemon_corefile_limit    => $daemon_corefile_limit,
      }

}

