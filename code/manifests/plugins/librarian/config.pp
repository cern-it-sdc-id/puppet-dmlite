class dmlite::plugins::librarian::config (
    $enable_librarian	= $dmlite::plugins::librarian::params::enable_librarian
) inherits dmlite::plugins::librarian::params {

    file {
      "/etc/dmlite.conf.d/librarian.conf":
        content => template("dmlite/plugins/librarian.conf.erb"),
        require => Package["dmlite-plugins-librarian"]
    }
}
