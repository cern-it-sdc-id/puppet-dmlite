class dmlite::plugins::vfs::params (
) inherits dmlite::params {
    $enable_vfs         = true

    $token_id           = "id"
    $token_life         = 1000

    $catalog_path       = "/var/lib/dmlite-vfs-catalog"
    $data_path          = "/var/lib/dmlite-vfs-data"
}
