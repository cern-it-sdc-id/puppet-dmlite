class dmlite::plugins::librarian {

  Class[Dmlite::Plugins::Librarian::Install] -> Class[Dmlite::Plugins::Librarian::Config]

  class{'dmlite::plugins::librarian::config':}
  class{'dmlite::plugins::librarian::install':}

}
