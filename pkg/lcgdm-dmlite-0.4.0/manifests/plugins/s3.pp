class dmlite::plugins::s3 {

  Class[dmlite::plugins::s3::install] -> Class[dmlite::plugins::s3::config] -> Class[dmlite::plugins::s3::service]

  class{'dmlite::plugins::s3::config':}
  class{'dmlite::plugins::s3::install':}
  class{'dmlite::plugins::s3::service':}

}
