#!/usr/bin/ruby
require 'facter'

begin
  #calling "rpm" on debian just doesn't work and breaks facter, and the each_line method then fails on the nil variable "version"
  version = Facter::Util::Resolution.exec("rpm -qa --queryformat '[%{NAME} %{VERSION}-%{RELEASE}\n]' | egrep 'dpm-xrootd'")
  version.each_line do |package|
    Facter.add("package_#{package.split[0]}".gsub('-','_')) do
      setcode do
        "#{package.split[1]}"
      end
    end
  end
rescue
  nil
end