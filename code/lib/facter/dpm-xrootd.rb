require 'puppet'
pkg = Puppet::Type.type(:package).create(:name => "dpm-xrootd")
Facter.add("dpm_xrootd_version") do
  setcode do
    pkg.retrieve[pkg.property(:ensure)]
  end
end
