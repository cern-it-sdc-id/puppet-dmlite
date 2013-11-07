class dmlite::dav::params (
) inherits dmlite::params {
    $dmlite_conf        = "/etc/dmlite.conf"
    $ns_type            = "Head"
    $ns_prefix          = "dpm"
    $ns_flags           = "Write"
    $ns_anon            = "nobody:nogroup"
    $ns_max_replicas    = 3
    $ns_secure_redirect = "Off"
    $ns_trusted_dns     = undef
    $disk_flags         = "Write"
    $disk_anon          = "nobody:nogroup"
    $ssl_cert           = "/etc/grid-security/hostcert.pem"
    $ssl_key            = "/etc/grid-security/hostkey.pem"
    $ssl_capath         = "/etc/grid-security/certificates"
    $ssl_ciphersuite    = "NULL-MD5:NULL:RC4-MD5:RC4:+LOW:+MEDIUM:+HIGH:+EXP"
    $log_error          = "logs/ssl_error_log"
    $log_transfer       = "logs/ssl_access_log"
    $log_level          = "warn"
    $user               = "dpmmgr"
    $group              = "dpmmgr"
    $coredump_dir       = undef
    $ulimit             = undef
    $enable_ns          = true
    $enable_disk        = true
    $enable_ssl         = true
    $enable_plain       = false
}
