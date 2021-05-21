class Station
  attr_accessor :trains, :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def arrived_train(train)
    trains.push(train.to_s)
  end

  def departed_train(train)
    trains.delete(train.to_s)
  end

  def trains_here
    trains.each { |train| puts train }
  end

  def trains_by_type(type)
    trains.select { |t| t.type == type }
  end

end
