class dmlite::python (
) inherits dmlite::python::params {

  Class[Dmlite::Python::Install] -> Class[Dmlite::Python::Config]

  class{"dmlite::python::install":}
  class{"dmlite::python::config":}

}
