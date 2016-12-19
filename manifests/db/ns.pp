class dmlite::db::ns ($flavor , $dbuser, $dbpass, $dbhost) inherits dmlite::db::params {

  # the packaged db script explicitly creates the db, we don't want that
  file_line { "${flavor} mysql commentcreate":
    ensure => present,
    match  => 'CREATE DATABASE.*',
    line   => '-- CREATE DATABASE.*',
    path   => "/usr/share/dmlite/dbscripts/cns_mysql_db.sql"
  }

  mysql::db { $dmlite::db::params::ns_db:
    user     => "${dbuser}",
    password => "${dbpass}",
    host     => "${dbhost}",
    sql      => "/usr/share/dmlite/dbscripts/cns_mysql_db.sql",
    require  => File_line["${flavor} mysql commentcreate"],
  }

  if $dbhost != 'localhost'  and $dbhost != "${::fqdn}" {
        #create the database grants for the user
        mysql_grant { "${dbuser}@${::fqdn}/${dmlite::db::params::ns_db}.*":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            provider   => 'mysql',
            user       => "${dbuser}@${::fqdn}",
            table      => "${dmlite::db::params::ns_db}.*",
            require    => [Mysql_database["${dmlite::db::params::ns_db}"], Mysql_user["${dbuser}@${::fqdn}"], ],
        }
  }

}
