class dmlite::plugins::memcache::config (
  $servers          = $dmlite::plugins::memcache::params::servers,
  $enable_memcache  = $dmlite::plugins::memcache::params::enable_memcache,
  $pool_size        = $dmlite::plugins::memcache::params::pool_size,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group,
  $protocol         = $dmlite::plugins::memcache::params::protocol,
  $posix            = $dmlite::plugins::memcache::params::posix,
  $expiration_limit = $dmlite::plugins::memcache::params::expiration_limit,
  $func_counter     = $dmlite::plugins::memcache::params::func_counter,
) inherits dmlite::plugins::memcache::params {

  validate_array($servers)
  validate_bool($enable_memcache)
  if is_numeric($pool_size) == false {
    fail("The parameter '${pool_size}' provided is not a number. Please provide a positive integer.")
  }
  if is_numeric($expiration_limit) == false {
    fail("The parameter '${expiration_limit}' provided is not a number. Please provide a positive integer.")
  }
  validate_re($protocol, '^(ascii|binary)$',
    "'${protocol}' is not a valid memcached protocol. It should be 'ascii' or 'binary'.")

  validate_re($func_counter, '^(on|off)$',
    "'${func_counter}' is not a valid parameter. It should be 'on' or 'off'.")

  file {
    "/etc/dmlite.conf.d/memcache.conf":
      ensure  => absent;
  }

  if $enable_memcache {
    file {
      "/etc/dmlite.conf.d/zmemcache.conf":
        owner     => $user,
        group     => $group,
        mode    => 0600,
        content => template("dmlite/plugins/memcache.conf.erb"),
        require => Package["dmlite-plugins-memcache"]
    }
  }
  else {
    file {
      "/etc/dmlite.conf.d/zmemcache.conf":
        ensure  => absent;
    }
  }

}
