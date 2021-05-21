class Route
  attr_accessor :stations

  def initialize(first, last)
    @stations = [first, last]  
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
 