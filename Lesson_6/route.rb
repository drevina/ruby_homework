class Route
  include InstanceCounter
  
  attr_accessor :stations

  def initialize(first, last)
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
    stations.each { |station| puts station }
  end   

end
 