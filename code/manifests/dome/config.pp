class dmlite::dome::config (
  $fcgi_dome_path             = $dmlite::dome::params::fcgi_dome_path
  $fcgi_dome_port             = $dmlite::dome::params::fcgi_dome_port
  $fcgi_listen_queue_depth    = $dmlite::dome::params::fcgi_listen_queue_depth
  $fcgi_processes             = $dmlite::dome::params::fcgi_processes
  $fcgi_idle_timeout          = $dmlite::dome::params::fcgi_idle_timeout
  $fcgi_dome_initial_env      = $dmlite::dome::params::fcgi_dome_initial_env
  $dome_head                  = $dmlite::dome::params::dome_head
  $dome_disk                  = $dmlite::dome::params::dome_disk
) inherits dmlite::dome::params {

  validate_bool($dome_head)
  validate_bool($dome_disk)

  $dome_template = 'dmlite/dome/zdome.conf'
  file {
    '/etc/httpd/conf.d/zdome.conf':
      ensure  => present,
      content => template("${dome_template}");
  }


  Class[dmlite::dome::install] -> Class[dmlite::dome::config]

  # some installations don't have complete data types enabled by default, use
  # str2bool to catch both cases
  if(str2bool("${::selinux}") != false) {
    selboolean{'httpd_can_network_connect': value => on, persistent => true }
    selboolean{'httpd_execmem': value => on, persistent => true }
  }

}
