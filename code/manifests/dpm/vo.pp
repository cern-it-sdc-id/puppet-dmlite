define dmlite::dpm::vo(
  $domain = $dmlite::dpm::config::domain
) {

  Dmlite::Domain[$domain] -> Dmlite::Vo[$name]

  $vopath = "/${dmlite::dpm::config::basepath}/${domain}/home/${name}"

  exec { "ns_vo_$domain_$name":
    path    => "/usr/bin:/usr/sbin",
    command => "dmlite-shell -e \"mkdir ${vopath} p\"; dmlite-shell -e \"chmod ${vopath} 755\"; dmlite-shell -e \"entergrpmap --group ${name} ${vopath}\"; dmlite-shell -e \"chown ${vopath} root:${name}\"; dmlite-shell -e \"chmod ${vopath} 775\"",
    unless  => "dmlite-shell -e \"ls ${vopath}\""
  }

}

