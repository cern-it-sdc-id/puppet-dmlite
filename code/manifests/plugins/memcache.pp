class dmlite::plugins::memcache {

  Class[Dmlite::Plugins::Memcache::Install] -> Class[Dmlite::Plugins::Memcache::Config] -> Class[Dmlite::Plugins::Memcache::Service]

  class{"dmlite::plugins::memcache::config":}
  class{"dmlite::plugins::memcache::install":}
  class{"dmlite::plugins::memcache::service":}

}
