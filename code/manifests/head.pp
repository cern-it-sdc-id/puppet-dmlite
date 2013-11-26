class dmlite::head (
  $token_password,
  $token_id   = "ip",
  $mysql_username,
  $mysql_password,
  $mysql_host = "localhost",
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $debuginfo  = false,
) {
  class{"dmlite::config::head":}
  class{"dmlite::install":
    debuginfo => $debuginfo
  }
  class{"dmlite::plugins::adapter::config::head":
    token_password => "${token_password}",
    token_id       => "${token_id}",
    dpmhost        => "${dpmhost}",
    nshost         => "${nshost}"
  }
  class{"dmlite::plugins::adapter::install":}

  class{"dmlite::plugins::mysql::config":
    mysql_host     => "${mysql_host}",
    mysql_username => "${mysql_username}",
    mysql_password => "${mysql_password}",
  }
  class{"dmlite::plugins::mysql::install":}
}
