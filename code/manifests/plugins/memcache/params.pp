class dmlite::plugins::memcache::params (
) inherits dmlite::params {
    $servers               = hiera('dmlite::plugins::memcache::params::servers', ["localhost:11211"])
    $pool_size             = hiera('dmlite::plugins::memcache::params::pool_size', 250)
    $symlink_limit         = hiera('dmlite::plugins::memcache::params::symlink_limit', 5)
    $expiration_limit      = hiera('dmlite::plugins::memcache::params::expiration_limit', 600)
    $protocol              = hiera('dmlite::plugins::memcache::params::protocol', "binary")
    $hash_distribution     = hiera('dmlite::plugins::memcache::params::hash_distribution', "default")
    $posix                 = hiera('dmlite::plugins::memcache::params::posix', "on")
    $func_counter          = hiera('dmlite::plugins::memcache::params::func_counter', "off")
    $local_cache_size      = hiera('dmlite::plugins::memcache::params::local_cache_size', 0)

    $enable_memcache       = hiera('dmlite::plugins::memcache::params::enable_memcache', true)
    $enable_memcache_cat   = hiera('dmlite::plugins::memcache::params::enable_memcache_cat', false)
    $enable_memcache_pool  = hiera('dmlite::plugins::memcache::params::enable_memcache_pool', false)
}
