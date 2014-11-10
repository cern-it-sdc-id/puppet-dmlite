class dmlite::dpm::config (
  $head,
  $flavor
) {
  case $flavor {
    dpns: { $basepath = "dpm" }
    lfc: { $basepath = "grid" }
  }
  $headnode = $head
}
