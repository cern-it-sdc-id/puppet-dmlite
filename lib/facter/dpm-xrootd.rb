#!/usr/bin/ruby
require 'facter'

version = Facter::Util::Resolution.exec("rpm -qa --queryformat '[%{NAME} %{VERSION}-%{RELEASE}\n]' | egrep 'dpm-xrootd'")

version.each_line do |package|
  Facter.add("package_#{package.split[0]}".gsub('-','_')) do
    setcode do
      "#{package.split[1]}"
    end
  end
end
