class dmlite::plugins::hdfs {

  Class[dmlite::plugins::hdfs::install] -> Class[dmlite::plugins::hdfs::config]

  class{'dmlite::plugins::hdfs::config':}
  class{'dmlite::plugins::hdfs::install':}

}
