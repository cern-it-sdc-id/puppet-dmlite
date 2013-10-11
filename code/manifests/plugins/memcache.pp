class dmlite::plugins::memcache(
  $pool_size = 32
)  {

  Class[Dmlite::Plugins::Memcache::Install] -> Class[Dmlite::Plugins::Memcache::Config]

  class{"dmlite::plugins::memcache::config":
    pool_size => $pool_size
  }
  class{"dmlite::plugins::memcache::install":}

}
