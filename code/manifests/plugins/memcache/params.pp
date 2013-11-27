class dmlite::plugins::memcache::params (
) inherits dmlite::params {
    $servers            = ["localhost:11211"]
    $pool_size          = 32
    $symlink_limit      = 5
    $expiration_limit   = 60
    $protocol           = "binary"
    $hash_distribution  = "default"
    $strict_consistency = "off"

    $enable_memcache    = true
}
