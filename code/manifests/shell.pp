class dmlite::shell (
) inherits dmlite::shell::params {

  Class[dmlite::shell::install] -> Class[dmlite::shell::config]

  class{'dmlite::shell::install':}
  class{'dmlite::shell::config':}

}
