class dmlite::plugins::memcache(
  $servers          = $dmlite::params::servers,
  $enable_memcache  = $dmlite::plugins::memcache::params::enable_memcache,
  $pool_size        = $dmlite::plugins::memcache::params::pool_size,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group,
  $protocol         = $dmlite::params::protocol,
  $expiration_limit = $dmlite::params::expiration_limit
)  {

  Class[Dmlite::Plugins::Memcache::Install] -> Class[Dmlite::Plugins::Memcache::Config]

  class{"dmlite::plugins::memcache::config":
    servers          => $servers,
    enable_memcache  => $enable_memcache,
    pool_size        => $pool_size,
    user             => "${user}",
    group            => "${group}",
    protocol         => "${protocol}",
    expiration_limit => $expiration_limit
  }
  class{"dmlite::plugins::memcache::install":}

}
