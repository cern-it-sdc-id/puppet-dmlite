class dmlite::plugins::profiler::install (
) inherits dmlite::plugins::profiler::params {

  include dmlite

  package {"dmlite-plugins-profiler":
    ensure => present;
  }

}
