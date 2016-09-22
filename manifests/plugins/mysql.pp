class dmlite::plugins::mysql {

  Class[dmlite::plugins::mysql::install] -> Class[dmlite::plugins::mysql::config] -> Class[dmlite::plugins::mysql::service]

  class{'dmlite::plugins::mysql::config':}
  class{'dmlite::plugins::mysql::install':}
  class{'dmlite::plugins::mysql::service':}

}
