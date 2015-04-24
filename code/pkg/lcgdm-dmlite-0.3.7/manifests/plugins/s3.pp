class dmlite::plugins::s3 {

  Class[Dmlite::Plugins::S3::Install] -> Class[Dmlite::Plugins::S3::Config] -> Class[Dmlite::Plugins::S3::Service]

  class{'dmlite::plugins::s3::config':}
  class{'dmlite::plugins::s3::install':}
  class{'dmlite::plugins::s3::service':}

}
