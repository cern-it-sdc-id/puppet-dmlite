class dmlite::plugins::oracle {

  Class[Dmlite::Plugins::Oracle::Install] -> Class[Dmlite::Plugins::Oracle::Config] -> Class[Dmlite::Plugins::Oracle::Service]

  class{"dmlite::plugins::oracle::config":}
  class{"dmlite::plugins::oracle::install":}
  class{"dmlite::plugins::oracle::service":}

}
