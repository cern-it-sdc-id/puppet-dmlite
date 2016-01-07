class dmlite::plugins::mysql {

  Class[Dmlite::Plugins::Mysql::Install] -> Class[Dmlite::Plugins::Mysql::Config] -> Class[Dmlite::Plugins::Mysql::Service]

  class{'dmlite::plugins::mysql::config':}
  class{'dmlite::plugins::mysql::install':}
  class{'dmlite::plugins::mysql::service':}

}
