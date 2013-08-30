class dmlite::plugins::mysql::install (
) inherits dmlite::plugins::mysql::params {

    package { 
        "dmlite-plugins-mysql": 
            ensure => present; 
    }

}
