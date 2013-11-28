class dmlite::dav (
) inherits dmlite::dav::params {

  Class[Dmlite::Dav::Install] -> Class[Dmlite::Dav::Config] ~> Class[Dmlite::Dav::Service]

  include('dmlite::dav::install')
  include('dmlite::dav::config')
  include('dmlite::dav::service')

}
