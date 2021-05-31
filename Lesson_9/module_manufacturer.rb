module Manufacturer
  attr_accessor :manufacturer

  def set_manufacturer(name)
    self.manufacturer = name
  end

  def display_manufacturer
    manufacturer
  end
end
