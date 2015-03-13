class dmlite::gaiconfig (
){ 
  $filecontent= template("dmlite/gai/gai.conf.erb")

   exec {"set-gai-config":
       path        => "/usr/bin:/usr/sbin:/bin",
       command     => "echo '$filecontent' > /etc/gai.conf",
       onlyif      => "ls /etc/gai.conf",
       unless      => "test -s /etc/gai.conf"
   }
}
