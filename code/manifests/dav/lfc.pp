class dmlite::dav::lfc (
) inherits dmlite::dav::params {

  Class[Dmlite::Dav::Install] -> Class[Dmlite::Dav::Config] -> Class[Dmlite::Dav::Service]

  class{"dmlite::dav::install":}
  class{"dmlite::dav::config":
    ns_type      => "LFC",
    ns_prefix    => "grid",
    ns_flags     => "NoAuthn",
    enable_disk  => false,
    enable_plain => true,
    user         => 'lfcmgr',
    group        => 'lfcmgr',
  }
  class{"dmlite::dav::service":}

}
