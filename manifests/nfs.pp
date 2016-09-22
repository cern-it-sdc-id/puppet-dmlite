class dmlite::nfs {

  Class[dmlite::nfs::install] -> Class[dmlite::nfs::config] -> Class[dmlite::nfs::service]

  class{'dmlite::nfs::install':}
  class{'dmlite::nfs::config':}
  class{'dmlite::nfs::service':}

}
