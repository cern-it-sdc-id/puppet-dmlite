class dmlite::plugins::oracle::install (
) inherits dmlite::plugins::oracle::params {

    package { 
        "dmlite-plugins-oracle": 
            ensure => present; 
    }

}
