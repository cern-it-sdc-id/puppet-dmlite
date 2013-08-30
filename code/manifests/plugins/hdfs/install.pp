class dmlite::plugins::hdfs::install (
) inherits dmlite::plugins::hdfs::params {

    package { 
        "dmlite-plugins-hdfs": 
            ensure => present; 
    }

}
