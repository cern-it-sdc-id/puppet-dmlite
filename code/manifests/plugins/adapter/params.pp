class dmlite::plugins::adapter::params (
) inherits dmlite::params {
    $dpmhost            = undef
    $nshost             = undef
    $connection_timeout = 15
    $retry_limit        = 3
    $retry_interval     = 2
    $enable_dpm         = false
    $enable_ns          = false
    $enable_io          = false
    $enable_rfio        = true
    $enable_pooldriver  = true
    $with_db_plugin     = false

    $token_id           = "id"
    $token_life         = 1000
}
