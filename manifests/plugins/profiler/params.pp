class dmlite::plugins::profiler::params (
) inherits dmlite::params {
  $enable_profiler  = true
  $collectors       = $dmlite::plugins::profiler::params::collectors
  $auth             = 'userdn'
}
