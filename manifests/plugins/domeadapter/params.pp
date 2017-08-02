class dmlite::plugins::domeadapter::params (
) inherits dmlite::params {
    $davix_ca_path      = '/etc/grid-security/certificates'
    $davix_cert_path    = '/etc/grid-security/dpmmgr/dpmcert.pem'
    $davix_private_key_path = '/etc/grid-security/dpmmgr/dpmkey.pem'
    $dome_head_url 	= undef
    $dome_disk_url	= undef
    $enable_ns          = false
    $enable_io          = false
    $enable_pooldriver  = true
    $enable_catalog     = false
    $token_id           = 'id'
    $token_life         = 1000
    $token_password     = undef
    $disknode           = false
    $host_dn            = undef
}
