define dmlite::dpm::domain(
) {

  Class[Dmlite::Shell::Install] -> Dmlite::Domain <| |>
  Class[Dmlite::Dpm::Config] -> Dmlite::Domain<| |>

  $domainpath = "/${dmlite::dpm::config::basepath}/${name}"

  exec { "ns_domain_${name}":
    path        => "/usr/bin:/usr/sbin",
    command     => "dmlite-shell -e \"mkdir ${domainpath} p\"",
    unless      => "dmlite-shell -e \"ls ${domainpath}\""
  }

}

