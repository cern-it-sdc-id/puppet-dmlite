class dmlite::plugins::memcache(
  $servers          = $dmlite::params::servers,
  $enable_memcache  = $dmlite::plugins::memcache::params::enable_memcache,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group,
  $protocol         = $dmlite::params::protocol,
  $posix            = $dmlite::plugins::memcache::params::posix,
  $expiration_limit = $dmlite::plugins::memcache::params::expiration_limit,
  $func_counter     = $dmlite::plugins::memcache::params::func_counter,
  $lookup_table     = $dmlite::plugins::memcache::params::lookup_table,
)  {

  Class[Dmlite::Plugins::Memcache::Install] -> Class[Dmlite::Plugins::Memcache::Config]

  class{"dmlite::plugins::memcache::config":
    servers          => $servers,
    enable_memcache  => $enable_memcache,
    user             => "${user}",
    group            => "${group}",
    protocol         => "${protocol}",
    posix            => "${posix}",
    expiration_limit => $expiration_limit
    func_counter     => "${func_counter}",
    lookup_table     => "${lookup_table}",
  }
  class{"dmlite::plugins::memcache::install":}

}
