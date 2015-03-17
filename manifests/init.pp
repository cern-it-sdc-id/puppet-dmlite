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

class dmlite (
  $nodetype = 'head'
) {
  #  validate_re($nodetype, '^(head|disk)$',
  #  "${nodetype} is not a valid node type for dmlite. It should be one of 'head' and 'disk'.")
  #
  #  include('dmlite::install')
  #  if $nodetype == "head" {
  #    include('dmlite::config::head')
  #  } elsif $nodetype == "disk" {
  #    include('dmlite::config::disk')
  #  }
}
