class dmlite::db::ns ($flavor , $dbname, $dbuser, $dbpass, $dbhost) inherits dmlite::db::params {
  include 'mysql::server'

  # the packaged db script explicitly creates the db, we don't want that
  file_line { "${flavor} mysql commentcreate":
    ensure => present,
    match  => 'CREATE DATABASE.*',
    line   => '-- CREATE DATABASE.*',
    path   => "/usr/share/dmlite/dbscripts/cns_mysql_db.sql"
  }

  #workaroundworkaround for missing / db creation

  file_line { 'workaround for missing / db creation':
    ensure => present,
    line   => "insert into Cns_file_metadata  values(1, 1, 0, NULL, '/', 16877, 0, 0, 0, 0,UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, '-','','','','{}'); insert into Cns_unique_id values(1);",
    path   => "/usr/share/dmlite/dbscripts/cns_mysql_db.sql"
  }

  mysql::db { $dbname:
    user     => "${dbuser}",
    password => "${dbpass}",
    host     => "${dbhost}",
    sql      => "/usr/share/dmlite/dbscripts/cns_mysql_db.sql",
    require  => [File_line["${flavor} mysql commentcreate"],File_line['workaround for missing / db creation']]
  }

  if $dbhost != 'localhost'  and $dbhost != "${::fqdn}" {
        #create the database grants for the user
        mysql_grant { "${dbuser}@${::fqdn}/${dbname}.*":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            provider   => 'mysql',
            user       => "${dbuser}@${::fqdn}",
            table      => "${dbname}.*",
            require    => [Mysql_database["${dbname}"], Mysql_user["${dbuser}@${::fqdn}"], ],
        }
  }

}
