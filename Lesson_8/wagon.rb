require_relative "module_manufacturer"
class Wagon
  include Manufacturer
  attr_reader :type
end