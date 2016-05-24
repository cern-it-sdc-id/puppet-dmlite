class dmlite::disk_dome (
  $token_password,
  $token_id   = 'ip',
  $debuginfo  = false,
  $log_level      = 1,
  $logcomponents  = undef,
  $headnode_domeurl = undef,
) {
  class { 'dmlite::config::disk':
    log_level     => $log_level,
    logcomponents => $logcomponents
  }
  class{'dmlite::install':
    debuginfo => $debuginfo
  }
  class{'dmlite::plugins::domeadapter::config::disk':
    token_password => "${token_password}",
    token_id       => "${token_id}",
  }
  class{'dmlite::plugins::domeadapter::install':}

  class{'dmlite::dome::config':
    dome_head    => false,
    dome_disk    => true,
    headnode_domeurl => "${headnode_domeurl}"
  }

  class{'dmlite::dome::install':}

  class{'dmlite::dome::service':}
}
