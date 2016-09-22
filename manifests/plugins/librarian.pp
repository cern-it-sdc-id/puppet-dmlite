class dmlite::plugins::librarian {

  Class[dmlite::plugins::librarian::install] -> Class[dmlite::plugins::librarian::config]

  class{'dmlite::plugins::librarian::config':}
  class{'dmlite::plugins::librarian::install':}

}
