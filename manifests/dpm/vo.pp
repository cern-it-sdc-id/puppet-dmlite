define dmlite::dpm::vo(
  $domain = $dmlite::dpm::config::domain
)  {
  
  include dmlite::dpm::config
  
  Dmlite::Dpm::Domain[$domain] -> Dmlite::Dpm::Vo[$name]

  $vopath = "/${dmlite::dpm::config::basepath}/${domain}/home/${name}"
  
  exec { "ns_vo_${domain}_${name}":
    path    => '/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"mkdir ${vopath} p\"; dmlite-shell -e \"groupadd ${name}\"; dmlite-shell -e \"chgrp  ${vopath} ${name}\"; dmlite-shell -e \"chown ${vopath} root\"; dmlite-shell -e \"chmod ${vopath} 775\"",
    unless  => "dmlite-shell -e \"ls ${vopath}\"",
    require => Class['dmlite::db::ns']
  }

}

