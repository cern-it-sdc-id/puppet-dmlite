class dmlite::plugins::oracle {

  Class[dmlite::plugins::oracle::install] -> Class[dmlite::plugins::oracle::config] -> Class[dmlite::plugins::oracle::service]

  class{'dmlite::plugins::oracle::config':}
  class{'dmlite::plugins::oracle::install':}
  class{'dmlite::plugins::oracle::service':}

}
