class dmlite::plugins::memcache::config (
    $enable_memcache	= $dmlite::plugins::memcache::params::enable_memcache
) inherits dmlite::plugins::memcache::params {

    file {
      "/etc/dmlite.conf.d/zmemcache.conf":
        content => template("dmlite/plugins/memcache.conf.erb"),
        require => Package["dmlite-plugins-memcache"]
    }
}
