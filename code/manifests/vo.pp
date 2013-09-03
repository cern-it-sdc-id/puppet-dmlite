define dmlite::vo(
  $domain = $dmlite::dpm::config::domain
) {

  Class[Dmlite::Shell::Install] -> Dmlite::Domain <| |>

  Dmlite::Domain[$domain] -> Dmlite::Vo[$name]

  $vopath = "/${basepath}/${domain}/home/${name}"

  exec { "ns_vo_$domain_$name":
    path    => "/usr/bin:/usr/sbin",
    command => "dmlite-shell -e \"mkdir ${vopath} p\"; dmlite-shell -e \"chmod 755 ${vopath}\"; dmlite-shell -e \"entergrpmap --group ${name} ${vopath}\"; dmlite-shell -e \"chown root:${name} ${vopath}\"; dmlite-shell -e \"chmod 775 ${vopath}\"",
    unless  => "dmlite-shell -e \"ls ${vopath}\""
  }

}

