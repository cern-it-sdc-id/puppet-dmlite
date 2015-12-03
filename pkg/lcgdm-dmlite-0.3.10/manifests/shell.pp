class dmlite::shell (
) inherits dmlite::shell::params {

  Class[Dmlite::Shell::Install] -> Class[Dmlite::Shell::Config]

  class{'dmlite::shell::install':}
  class{'dmlite::shell::config':}

}
