class dmlite::plugins::profiler(
  $collectors = $dmlite::plugins::profiler::params::collectors,
  $auth       = $dmlite::plugins::profiler::params::auth,
) inherits dmlite::plugins::profiler::params {

  Class[dmlite::plugins::profiler::install] -> Class[dmlite::plugins::profiler::config]

  class{'dmlite::plugins::profiler::config':
    collectors => $collectors,
    auth       => $auth
  }
  class{'dmlite::plugins::profiler::install':}

}
