define dmlite::dpm::vo(
  $domain = $dmlite::dpm::config::domain
)  {
  
  include dmlite::dpm::config
  
  Dmlite::Dpm::Domain[$domain] -> Dmlite::Dpm::Vo[$name]

  $vopath = "/${dmlite::dpm::config::basepath}/${domain}/home/${name}"
  
  exec { "ns_vo_${domain}_${name}":
    path    => '/bin:/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"mkdir ${vopath} p\" && dmlite-shell -e \"groupadd ${name}\" && sleep 60 && dmlite-shell -e \"chgrp  ${vopath} ${name}\" && dmlite-shell -e \"chmod ${vopath} 775\"",
    unless  => "dmlite-shell -e \"ls ${vopath}\"",
    require => Class['dmlite::db::ns']
  }
  ->
  exec { "ns_basepath_setacl-dpnsbasedir-${domain}-${name}":
    path        => '/bin:/usr/bin:/usr/sbin:/bin',
    command     => "dmlite-shell -e \"acl /${dmlite::dpm::config::basepath}/${domain}/home  d:u::rwx,d:g::rwx,d:o::r-x,u::rwx,g::rwx,o::r-x set\"",
    unless      => "dmlite-shell -e \"acl /${dmlite::dpm::config::basepath}/${domain}/home \" | grep default:user: ",
  } ->
   exec { "ns_vopath_setacl-${domain}-${name}":
    path        => '/bin:/usr/bin:/usr/sbin:/bin',
    command     => "dmlite-shell -e \"acl ${vopath} d:u::rwx,d:g::rwx,d:o::r-x,u::rwx,g::rwx,o::r-x set\"",
    unless      => "dmlite-shell -e \"acl ${vopath} \" | grep default:user: ",
  }

}

