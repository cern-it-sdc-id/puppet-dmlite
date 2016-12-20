define dmlite::dpm::domain(
) {
  include dmlite::dpm::config 

  Class[dmlite::shell] -> Dmlite::Dpm::Domain <| |>
  Class[dmlite::dpm::config] -> Dmlite::Dpm::Domain<| |>

  $domainpath = "/${dmlite::dpm::config::basepath}/${name}"

  exec { "ns_domain_${name}":
    path    => '/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"mkdir ${domainpath} p\"",
    unless  => "dmlite-shell -e \"ls ${domainpath}\"",
    require => Class['dmlite::db::ns']
  }  

}

