class dmlite::plugins::profiler {

  Class[Dmlite::Plugins::Profiler::Install] -> Class[Dmlite::Plugins::Profiler::Config] -> Class[Dmlite::Plugins::Profiler::Service]

  class{"dmlite::plugins::profiler::config":}
  class{"dmlite::plugins::profiler::install":}
  class{"dmlite::plugins::profiler::service":}

}
