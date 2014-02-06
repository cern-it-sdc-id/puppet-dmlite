class dmlite::plugins::memcache::params (
) inherits dmlite::params {
    $servers            = ["localhost:11211"]
    $symlink_limit      = 5
    $expiration_limit   = 60
    $protocol           = "binary"
    $hash_distribution  = "default"
    $posix              = "on"
    $func_counter       = "off"
    $lookup_table       = "off"

    $enable_memcache    = true
}
