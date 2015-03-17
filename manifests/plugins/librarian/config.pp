class dmlite::plugins::librarian::config (
  $enable_librarian = $dmlite::plugins::librarian::params::enable_librarian,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group
) inherits dmlite::plugins::librarian::params {

  file {
    '/etc/dmlite.conf.d/librarian.conf':
      owner   => $user,
      group   => $group,
      mode    => '0600',
      content => template('dmlite/plugins/librarian.conf.erb'),
      require => Package['dmlite-plugins-librarian']
  }
}
