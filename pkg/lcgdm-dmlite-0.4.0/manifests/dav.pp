class dmlite::dav (
) inherits dmlite::dav::params {

  Class[dmlite::dav::install] -> Class[dmlite::dav::config] ~> Class[dmlite::dav::service]

  include('dmlite::dav::install')
  include('dmlite::dav::config')
  include('dmlite::dav::service')

}
