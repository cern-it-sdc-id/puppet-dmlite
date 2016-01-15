class dmlite::plugins::adapter {

  Class[dmlite::plugins::adapter::install] -> Class[dmlite::plugins::adapter::config] -> Class[dmlite::plugins::adapter::service]

  class{'dmlite::plugins::adapter::config':}
  class{'dmlite::plugins::adapter::install':}
  class{'dmlite::plugins::adapter::service':}

}
