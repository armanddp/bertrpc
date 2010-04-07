$:.unshift File.join(File.dirname(__FILE__), *%w[.])

require 'request'
require 'decodes'
require 'action'
require 'mod'
require 'error'
require 'encode'
require 'decode'
require 'binary'

# Global method for specifying that a string should be encoded as a binary list.
def b(string)
  ERPC::Binary.new(string)
end