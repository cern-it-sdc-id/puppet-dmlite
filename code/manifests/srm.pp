class dmlite::srm {

  Class[Dmlite::Srm::Install] -> Class[Dmlite::Srm::Config] -> Class[Dmlite::Srm::Service]

  class{"dmlite::srm::install":}
  class{"dmlite::srm::config":}
  class{"dmlite::srm::service":}

}
