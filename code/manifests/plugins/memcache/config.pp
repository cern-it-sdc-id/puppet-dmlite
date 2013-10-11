class dmlite::plugins::memcache::config (
    $enable_memcache	= $dmlite::plugins::memcache::params::enable_memcache,
    $pool_size = $dmlite::plugins::memcache::params::pool_size
) inherits dmlite::plugins::memcache::params {

    file {
      "/etc/dmlite.conf.d/memcache.conf":
        ensure  => absent;
    }

    file {
      "/etc/dmlite.conf.d/zmemcache.conf":
        content => template("dmlite/plugins/memcache.conf.erb"),
        require => Package["dmlite-plugins-memcache"]
    }
}
