class dmlite::plugins::librarian::install (
) inherits dmlite::plugins::librarian::params {

    package { 
        "dmlite-plugins-librarian": 
            ensure => present; 
    }

}
