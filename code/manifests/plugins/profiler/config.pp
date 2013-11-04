class dmlite::plugins::profiler::config (
    $enable_profiler	= $dmlite::plugins::profiler::params::enable_profiler
) inherits dmlite::plugins::profiler::params {

    file {
      "/etc/dmlite.conf.d/profiler.conf":
        owner   => "root",
        mode    => 0600,
        content => template("dmlite/plugins/profiler.conf.erb"),
        require => Package["dmlite-plugins-profiler"]
    }
}
