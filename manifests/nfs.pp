class dmlite::nfs {

  Class[Dmlite::Nfs::Install] -> Class[Dmlite::Nfs::Config] -> Class[Dmlite::Nfs::Service]

  class{"dmlite::nfs::install":}
  class{"dmlite::nfs::config":}
  class{"dmlite::nfs::service":}

}
