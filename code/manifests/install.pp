class dmlite::install (
) inherits dmlite::params {

    package { 
        "dmlite-libs": 
            ensure => present; 
    }

}
