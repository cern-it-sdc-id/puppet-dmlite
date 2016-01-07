class dmlite::plugins::hdfs {

  Class[Dmlite::Plugins::Hdfs::Install] -> Class[Dmlite::Plugins::Hdfs::Config]

  class{'dmlite::plugins::hdfs::config':}
  class{'dmlite::plugins::hdfs::install':}

}
