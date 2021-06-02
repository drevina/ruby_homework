class Station
  include InstanceCounter
  include Validation

  attr_accessor :trains, :station_name

  validate :station_name, :format, /^[\w\d]+/
  validate :name, :presence

  @@all_stations = []

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    validate!
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

  def trains_block
    trains.each { |train| yield(train) }
  end

end
