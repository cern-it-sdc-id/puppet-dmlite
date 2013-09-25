class dmlite::plugins::memcache {

  Class[Dmlite::Plugins::Memcache::Install] -> Class[Dmlite::Plugins::Memcache::Config]

  class{"dmlite::plugins::memcache::config":}
  class{"dmlite::plugins::memcache::install":}

}
