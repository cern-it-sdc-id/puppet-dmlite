class dmlite::dpm::config (
  $flavor = 'dpns'
) {
  case $flavor {
    dpns: { $basepath = 'dpm' }
    lfc: { $basepath = 'grid' }
    default: { fail("Flavor ${flavor} is not supported by puppet-dmlite") }
  }
}
