class dmlite::dpm::config (
  $head,
  $flavor
) {
  case $flavor {
    dpns: { $basepath = 'dpm' }
    lfc: { $basepath = 'grid' }
    default: { fail("Flavor ${flavor} is not supported by puppet-dmlite") }
  }

  $headnode = $head
}
