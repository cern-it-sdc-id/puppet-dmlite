#
# map_hash.rb
#

module Puppet::Parser::Functions
  newfunction(:map_hash, :type => :rvalue, :doc => <<-EOS
This function maps something onto each element of a hash.

*Examples:*

    later ...

Will return: nothing ...
    EOS
  ) do |arguments|
    raise(Puppet::ParseError, "map_hash(): Wrong number of arguments " +
          "(given #{arguments.size} for 2)") if arguments.size < 2

    hash = arguments[0]

    unless hash.is_a?(Hash)
      raise Puppet::ParseError, "map_hash(): expected first argument to be a Hash, got #{hash.inspect}"
    end

    puppet_string = arguments[1]

    # sanity check for arg[1]

    result = hash.inject({}) { |h, (key,value)| h[key] = puppet_string % [ key, value ]; h }

    return result
  end
end
