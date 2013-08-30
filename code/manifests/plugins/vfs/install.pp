class dmlite::plugins::vfs::install (
) inherits dmlite::plugins::vfs::params {

    package { 
        "dmlite-plugins-vfs": 
            ensure => present; 
    }

}
