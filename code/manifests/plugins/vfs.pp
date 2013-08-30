class dmlite::plugins::vfs {

  Class[Dmlite::Plugins::Vfs::Install] -> Class[Dmlite::Plugins::Vfs::Config] -> Class[Dmlite::Plugins::Vfs::Service]

  class{"dmlite::plugins::vfs::config":}
  class{"dmlite::plugins::vfs::install":}
  class{"dmlite::plugins::vfs::service":}

}
