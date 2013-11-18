class dmlite::plugins::librarian {

  Class[Dmlite::Plugins::Librarian::Install] -> Class[Dmlite::Plugins::Librarian::Config] -> Class[Dmlite::Plugins::Librarian::Service]

  class{"dmlite::plugins::librarian::config":}
  class{"dmlite::plugins::librarian::install":}

}
