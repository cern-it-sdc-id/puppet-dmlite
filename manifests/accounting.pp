class dmlite::accounting (
  $cron_interval = hiera('dmlite::accounting::cron_interval','weekly'),
  $bdii_url = hiera('dmlite::accounting::bdii_url','ldap://lcg-bdii.cern.ch:2170'),
  $broker_network = hiera('dmlite::accounting::broker_network','PROD'),
  $broker_host = hiera('dmlite::accounting::broker_host',''),
  $broker_port = hiera('dmlite::accounting::broker_port',''),
  $use_ssl = hiera('dmlite::accounting::use_ssl',true),
  $certificate = hiera('dmlite::accounting::certificate','/etc/grid-security/dpmmgr/dpmcert.pem'),
  $key = hiera('dmlite::accounting::key','/etc/grid-security/dpmmgr/dpmkey.pem'),
  $capath = hiera('dmlite::accounting::capath','/etc/grid-security/certificates'),

  $server_cert=  hiera('dmlite::accounting::server_cert',''),
  $messaging_destination = hiera('dmlite::accounting::server_cert','/queue/global.accounting.test.storage.central'),
  $messaging_path = hiera('dmlite::accounting::messaging_path','/var/spool/apel/outgoing'),
  
  
  $site_name = hiera('dmlite::accounting::site_name',''),
  $nsconfig =  hiera('dmlite::accounting::nsconfig','/usr/etc/NSCONFIG'), 

  $log_file =  hiera('dmlite::accounting::log_file','/var/log/apel/ssmsend.log'),
  $log_level = hiera('dmlite::accounting::log_level', 'INFO'),
  $console = hiera('dmlite::accounting::console', true),
  $ssm_url = hiera('dmlite::accounting::ssm_url', 'https://github.com/apel/ssm/releases/download/2.1.7-1/apel-ssm-2.1.7-1.el6.noarch.rpm'),

) {

 if $site_name == '' {
  fail("'site_name' not defined")
 }
 #install
 package {'python-daemon':
  ensure => 'installed',
 }   
 package {'python-ldap':
  ensure => 'installed',
 }
 package {'python-lockfile':
  ensure => 'installed',
 }
 package {'stomppy':
  ensure => 'installed',
 }
 package { 'apel-ssm':
  ensure => 'installed',
  source => $ssm_url,
  provider => 'rpm'
 } 
 
 file {'/etc/apel/sender.cfg':
   ensure  => present,
   owner   => root,
   group   => root,
   content => template('dmlite/ssm/sender.cfg.erb'),
   require => Package['apel-ssm']
 }
 
 file {"/etc/cron.${cron_interval}/dpm-accounting":
    owner   => root,
    group   => root,
    mode    => '0755',
    content => inline_template("
#!/bin/sh

/bin/mkdir -p /var/spool/apel/outgoing/`/bin/date +%Y%m%d` && 
/usr/share/lcgdm/scripts/star-accounting.py --reportgroups --nsconfig=<%= @nsconfig %> --site=<%= @site_name %> > /var/spool/apel/outgoing/`/bin/date +%Y%m%d`/`date +%Y%m%d%H%M%S` && ssmsend
"),
    require => Package['apel-ssm'],
    ensure => present
  }

}
