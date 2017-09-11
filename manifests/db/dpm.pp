class dmlite::db::dpm ($dbuser, $dbpass, $dbhost) inherits dmlite::db::params {

  # the packaged db script explicitly creates the db, we don't want that
  file_line { 'dpm mysql commentcreate':
    ensure => present,
    match  => 'CREATE DATABASE.*',
    line   => '-- CREATE DATABASE.*',
    path   => '/usr/share/dmlite/dbscripts/dpm_mysql_db.sql'
  }

  mysql::db { $dmlite::db::params::dpm_db:
    user     => "${dbuser}",
    password => "${dbpass}",
    host     => "${dbhost}",
    sql      => '/usr/share/dmlite/dbscripts/dpm_mysql_db.sql',
    require  => File_line['dpm mysql commentcreate']
  }

  if $dbhost != 'localhost' and $dbhost != "${::fqdn}" {
        #create the DB user and the grants

        mysql_user { "${dbuser}@${::fqdn}":
            ensure        => present,
            password_hash => mysql_password($dbpass),
            provider      => 'mysql',
        }
        mysql_grant { "${dbuser}@${::fqdn}/${dmlite::db::params::dpm_db}.*":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            provider   => 'mysql',
            user       => "${dbuser}@${::fqdn}",
            table      => "${dmlite::db::params::dpm_db}.*",
            require    => [Mysql_database["${dmlite::db::params::dpm_db}"], Mysql_user["${dbuser}@${::fqdn}"], ],
        }
  } 
}
