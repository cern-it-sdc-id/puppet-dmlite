
class dmlite::dav::install (
) inherits dmlite::dav::params {

    package {
      "lcgdm-dav-server":
        ensure => present;
    }

   $filecontent= template("dmlite/dav/fetch-crl-patch")

   include('fetchcrl') ->
   exec {"fetch-crl-patch":
       path        => "/usr/bin:/usr/sbin:/bin",
       command     => "echo '$filecontent' > /tmp/fetch-crl-patch;/bin/bash /tmp/fetch-crl-patch",
       unless      => "grep -q 'service httpd reload' '/etc/cron.d/fetch-crl'"
   }

}
