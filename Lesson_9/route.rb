class Route
  include InstanceCounter

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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Название должно содержать 3 или более символов' if first.length < 3 || last.length < 3
  end
end
