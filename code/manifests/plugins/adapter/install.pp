class dmlite::plugins::adapter::install (
) inherits dmlite::plugins::adapter::params {

    package { 
        "dmlite-plugins-adapter": 
            ensure => present; 
    }

}
