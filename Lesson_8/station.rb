require_relative "module_instance_counter"
class Station
  include InstanceCounter

  attr_accessor :trains, :station_name

  @@all_stations = []

  def initialize(station_name)
    @station_name = station_name.to_s
    validate!
    @trains = []
    @@all_stations << self.station_name
    register_instance
  end

  def self.all
    @@all_stations
  end

  def arrived_train(train)
    trains.push(train.to_s)
  end

  def departed_train(train)
    trains.delete(train.to_s)
  end

  def trains_by_type(type)
    trains.select { |t| t.type == type }
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Наименование должно содержать 3 или более символов" if station_name.length < 3 
    raise "Такая станция уже существует" if @@all_stations.include? station_name
  end
end
