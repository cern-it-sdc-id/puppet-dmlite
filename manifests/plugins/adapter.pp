class dmlite::plugins::adapter {

  Class[Dmlite::Plugins::Adapter::Install] -> Class[Dmlite::Plugins::Adapter::Config] -> Class[Dmlite::Plugins::Adapter::Service]

  class{'dmlite::plugins::adapter::config':}
  class{'dmlite::plugins::adapter::install':}
  class{'dmlite::plugins::adapter::service':}

}
