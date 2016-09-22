class dmlite::dav::lfc (
) inherits dmlite::dav::params {

  Class[dmlite::dav::install] -> Class[dmlite::dav::config] -> Class[dmlite::dav::service]

  class{'dmlite::dav::install':}
  class{'dmlite::dav::config':
    ns_type      => 'LFC',
    ns_prefix    => 'grid',
    ns_flags     => 'NoAuthn',
    enable_disk  => false,
    enable_http  => true,
    enable_https => true,
    user         => 'lfcmgr',
    group        => 'lfcmgr',
  }
  class{'dmlite::dav::service':}

}
