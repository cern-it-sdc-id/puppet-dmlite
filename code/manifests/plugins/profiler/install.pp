class dmlite::plugins::profiler::install (
) inherits dmlite::plugins::profiler::params {

    package { 
        "dmlite-plugins-profiler": 
            ensure => present; 
    }

}
