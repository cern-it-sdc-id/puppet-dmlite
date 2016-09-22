class dmlite::plugins::domeadapter {

  Class[dmlite::plugins::domeadapter::install] -> Class[dmlite::plugins::domeadapter::config] -> Class[dmlite::plugins::domeadapter::service]

  class{'dmlite::plugins::domeadapter::config':}
  class{'dmlite::plugins::domeadapter::install':}
  class{'dmlite::plugins::domeadapter::service':}

}
