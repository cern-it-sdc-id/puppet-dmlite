class dmlite::plugins::adapter::params (
) inherits dmlite::params {
    $dpm_host           = undef
    $ns_host            = undef
    $connection_timeout = 2
    $retry_limit        = 3
    $retry_interval     = 2
    $enable_dpm         = false
    $enable_ns          = false
    $enable_io          = false
    $enable_rfio        = true
    $enable_pooldriver  = true

    $token_id           = "id"
    $token_life         = 1000
}
