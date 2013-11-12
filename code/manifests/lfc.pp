class dmlite::lfc (
  $dbflavor,
  $dbuser,
  $dbpass,
  $dbhost     = "localhost",
  $dpmhost    = "${::fqdn}",
  $nshost     = "${::fqdn}",
  $debuginfo  = false,
) {
  # for the LFC, the token password is not used
  $token_password = "gfgzmup)itecwhvjckp2nvvdcgNurywvhrbIhlfiwp8ctmmwbr"

  class{"dmlite::config::lfc":}
  class{"dmlite::install":
    debuginfo => "${debuginfo}"
  }
  class{"dmlite::plugins::adapter::config::lfc":
    token_password => "${token_password}",
    dpmhost        => "${dpmhost}",
    nshost         => "${nshost}"
  }
  class{"dmlite::plugins::adapter::install":}
}
