class dmlite::dbupgrade (
   $version = undef,
   $db = 'dpm_db',
   $dbhost = 'localhost',
   $dbuser = under,
   $dbpass = undef,
){

  #if $version == undef {
  #	 fail("'version' is not defined")
  # }

  <%   
  require 'rubygems'
  require 'mysql'

  dbh = Mysql.real_connect('localhost', 'root', 'mysqlroot', 'dpm_db')
  dpm_db_version = dbh.query("select * from schema_version_dpm;")
  %>

  notify {"Running DPM DB version \$dpm_db_version ${dpm_db_version} ":}
  
}
