class dmlite::plugins::profiler(
  $collectors = $dmlite::plugins::profiler::params::collectors,
) inherits dmlite::plugins::profiler::params {

  Class[Dmlite::Plugins::Profiler::Install] -> Class[Dmlite::Plugins::Profiler::Config] -> Class[Dmlite::Plugins::Profiler::Service]

  class{"dmlite::plugins::profiler::config":
    collectors => $collectors
  }
  class{"dmlite::plugins::profiler::install":}
  class{"dmlite::plugins::profiler::service":}

}
