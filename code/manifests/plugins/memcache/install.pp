class dmlite::plugins::memcache::install (
) inherits dmlite::plugins::memcache::params {

    package { 
        "dmlite-plugins-memcache": 
            ensure => present; 
    }

}
