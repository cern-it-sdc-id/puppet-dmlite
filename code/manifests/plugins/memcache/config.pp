class dmlite::plugins::memcache::config (
  $servers          = $dmlite::plugins::memcache::params::servers,
  $enable_memcache  = $dmlite::plugins::memcache::params::enable_memcache,
  $pool_size        = $dmlite::plugins::memcache::params::pool_size,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group,
  $protocol         = $dmlite::plugins::memcache::params::protocol,
  $expiration_limit = $dmlite::plugins::memcache::params::expiration_limit
) inherits dmlite::plugins::memcache::params {

  validate_array($servers)
  validate_bool($enable_memcache)
  if is_numeric($expiration_limit) == false {
    fail("The ${expiration_limit} provided is not a number. Please provide a positive integer.")
  }
  validate_re($protocol, '^(ascii|binary)$',
    "${protocol} is not a valid memcached protocol. It should be 'ascii' or 'binary'.")

  file {
    "/etc/dmlite.conf.d/memcache.conf":
      ensure  => absent;
  }

  file {
    "/etc/dmlite.conf.d/zmemcache.conf":
      owner     => $user,
      group     => $group,
      mode    => 0600,
      content => template("dmlite/plugins/memcache.conf.erb"),
      require => Package["dmlite-plugins-memcache"]
  }
}
