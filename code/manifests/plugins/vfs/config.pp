class dmlite::plugins::vfs::config (
    $enable_vfs	= $dmlite::plugins::vfs::params::enable_vfs
) inherits dmlite::plugins::vfs::params {

    file {
      "/etc/dmlite.conf.d/vfs.conf":
        owner   => "root",
        mode    => 0600,
        content => template("dmlite/plugins/vfs.conf.erb"),
        require => Package["dmlite-plugins-vfs"]
    }
}
