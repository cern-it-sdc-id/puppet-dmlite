class dmlite::dav::install (
) inherits dmlite::dav::params {

    package {
      'lcgdm-dav-server':
        ensure => present;
    }

  $filecontent= template('dmlite/dav/fetch-crl-patch')

  exec { 'fetch-crl-patch':
    path    => '/usr/bin:/usr/sbin:/bin',
    command => "bash ${filecontent}",
    unless  => 'grep -q \'fetch-crl-cron\' \'/etc/cron.d/fetch-crl\'',
    require => Class[fetchcrl],
  }

  cron { 'session cache cleaner':
    ensure  => 'present',
    command => '/usr/bin/find /var/www/sessions -type f -cmin +120 -delete',
    user    => 'root',
    minute  => '00',
  }
  
  cron { 'graceful http restart':
    ensure  => 'present',
    command => '/usr/sbin/apachectl graceful >& /dev/null',
    minute  => fqdn_rand(60,'apache'),
    hour    => '*/6',
  }
}
