class dmlite::bdii (
  $site_name = undef,
  $dpm_info_provider = 'dome',
  $ldap_user_cert = '/var/lib/ldap/hostcert.pem',
  $ldap_user_key = '/var/lib/ldap/hostkey.pem'
) {

  @user { 'ldap':
    groups      => ["${dmlite::base::params::user}"],
    membership => minimum,
  }
  
  file { '/var/lib/bdii/gip/provider/se-dpm':
    ensure  => absent,
  }

  file { '/var/lib/bdii/gip/provider/service-srm2.2':
    ensure => absent,
  }

  file { '/var/lib/bdii/gip/glite-info-service-srm2.2.conf':
    ensure  => absent,
  }
 
  file { '/etc/sysconfig/dpminfo':
    ensure  => present,
    content => template('dmlite/bdii/dpminfo.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { $ldap_user_cert:
    ensure => present,
    source => '/etc/grid-security/hostcert.pem',
    owner  => 'ldap',
    group  => 'ldap'
  }

  file { $ldap_user_key:
    ensure => present,
    mode   => '0400',
    source => '/etc/grid-security/hostkey.pem',
    owner  => 'ldap',
    group  => 'ldap'
  }
}

