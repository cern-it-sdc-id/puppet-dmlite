class dmlite::plugins::s3::install (
) inherits dmlite::plugins::s3::params {

    package { 
        "dmlite-plugins-s3": 
            ensure => present; 
    }

}
