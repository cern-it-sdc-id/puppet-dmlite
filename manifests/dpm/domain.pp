define dmlite::dpm::domain(
) {
  include dmlite::dpm::config 

  Class[dmlite::shell] -> Dmlite::Dpm::Domain <| |>
  Class[dmlite::dpm::config] -> Dmlite::Dpm::Domain<| |>

  $domainpath = "/${dmlite::dpm::config::basepath}/${name}"

  exec { "ns_domain_${name}":
    path    => '/bin:/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"mkdir ${domainpath} p\"",
    unless  => "dmlite-shell -e \"ls ${domainpath}\"",
    require => Class['dmlite::db::ns']
  } ->
  exec { "ns_basepath_setacl-${name}":
    path    => '/bin:/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"acl /${dmlite::dpm::config::basepath} d:u::rwx,d:g::rwx,d:o::r-x,u::rwx,g::r-x,o::r-x set\"",
    unless  => "dmlite-shell -e \"acl /${dmlite::dpm::config::basepath} \" | grep default:user: ",
    require => Class['dmlite::db::ns']
  } ->
   exec { "ns_basepath_setacl-domain-${name}":
    path    => '/bin:/usr/bin:/usr/sbin',
    command => "dmlite-shell -e \"acl ${domainpath} d:u::rwx,d:g::rwx,d:o::r-x,u::rwx,g::r-x,o::r-x set\"",
    unless  => "dmlite-shell -e \"acl ${domainpath} \" | grep default:user:",
    require => Class['dmlite::db::ns']
  } 

}

