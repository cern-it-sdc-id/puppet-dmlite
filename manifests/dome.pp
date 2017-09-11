class dmlite::dome (
) inherits dmlite::dome::params {

  Class[dmlite::dome::install] -> Class[dmlite::dome::config]

  include('dmlite::dome::install')
  include('dmlite::dome::config')

}
