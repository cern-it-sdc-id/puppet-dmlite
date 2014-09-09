class dmlite::disk (
  $token_password,
  $token_id   = "ip",
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $debuginfo  = false,
) {
  class{"dmlite::config::disk":}
  class{"dmlite::install":
    debuginfo => $debuginfo
  }
  class{"dmlite::plugins::adapter::config::disk":
    token_password => "${token_password}",
    token_id       => "${token_id}",
    dpmhost        => "${dpmhost}",
    nshost         => "${nshost}"
  }
  class{"dmlite::plugins::adapter::install":}
}
