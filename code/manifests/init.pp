# == Class: dmlite
#
# === Parameters
#
# Document parameters here.
#
#
# === Variables
#
#
# === Examples
#
#
# === Authors
#
# DPM Team <dpm-devel@cern.ch>
#
# === Copyright
#
# Copyright 2012 CERN, unless otherwise noted.
#

class dmlite {

  Class[Dmlite::Install] -> Class[Dmlite::Config]

  class{"dmlite::config":}
  class{"dmlite::install":}

}


