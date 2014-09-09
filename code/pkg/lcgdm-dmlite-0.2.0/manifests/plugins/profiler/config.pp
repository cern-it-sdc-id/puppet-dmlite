class dmlite::plugins::profiler::config (
  $enable_profiler  = $dmlite::plugins::profiler::params::enable_profiler,
  $user             = $dmlite::params::user,
  $group            = $dmlite::params::group
) inherits dmlite::plugins::profiler::params {

  file {
    "/etc/dmlite.conf.d/profiler.conf":
      owner   => $user,
      group   => $group,
      mode    => 0600,
      content => template("dmlite/plugins/profiler.conf.erb"),
      require => Package["dmlite-plugins-profiler"]
  }
}
