class dmlite::plugins::hdfs {

  Class[Dmlite::Plugins::Hdfs::Install] -> Class[Dmlite::Plugins::Hdfs::Config] -> Class[Dmlite::Plugins::Hdfs::Service]

  class{"dmlite::plugins::hdfs::config":}
  class{"dmlite::plugins::hdfs::install":}
  class{"dmlite::plugins::hdfs::service":}

}
