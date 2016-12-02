class dmlite::base::install () inherits dmlite::base::params {
  Class[dmlite::base::config] -> Class[dmlite::base::install]

  # still needed?
  #ensure_packages(['finger'])

  if $dmlite::base::config::egiCA {
    ensure_packages(['ca-policy-egi-core'])
  }
}
