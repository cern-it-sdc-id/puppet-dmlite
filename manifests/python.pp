class dmlite::python (
) inherits dmlite::python::params {

  Class[dmlite::python::install] -> Class[dmlite::python::config]

  class{'dmlite::python::install':}
  class{'dmlite::python::config':}

}
