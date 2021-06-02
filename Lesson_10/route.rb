class Route
  include InstanceCounter
  include Validation

  validate :first, :type, Station
  validate :last, :type, Station

  attr_accessor :stations, :first, :last

  def initialize(first, last)
    @first = first.to_s
    @last = last.to_s
    validate!
    @stations = [first, last]
    register_instance
  end

  def add_station(name)
    stations.insert(-2, name)
  end

  def delete_station(name)
    stations.delete(name)
  end

  def stations_list
    stations.each { |station| station }
  end

end
