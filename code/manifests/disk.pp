class dmlite::head (
  $token_password,
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $debuginfo  = false,
) {
  class{"dmlite::config::disk":}
  class{"dmlite::install":
    debuginfo => "${debuginfo}"
  }
  class{"dmlite::plugins::adapter::config::disk":
    token_password => "${token_password}",
    dpmhost        => "${dpmhost}",
    nshost         => "${nshost}"
  }
  class{"dmlite::plugins::adapter::install":}
}
