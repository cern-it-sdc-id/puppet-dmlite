class dmlite::dome::params (
) inherits dmlite::params {
    $fcgi_dome_path     	= '/var/www/fcgi-bin/dome'
    $fcgi_dome_port     	= 9001
    $fgci_listen_queue_depth 	= 500
    $fcgi_processes        	= 1
    $fcgi_idle_timeout  	= 300
    $fcgi_dome_initial_env      = 'DOME_CFGFILE=/etc/dome.conf'
    $dome_head       		= false
    $dome_disk   	        = true
}
