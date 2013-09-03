class dmlite::dav (
) inherits dmlite::dav::params {

  Class[Dmlite::Dav::Install] -> Class[Dmlite::Dav::Config] ~> Class[Dmlite::Dav::Service]

  class{"dmlite::dav::install":}
  class{"dmlite::dav::config":}
  class{"dmlite::dav::service":}

}
