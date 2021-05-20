class Route
  attr_accessor :stations

  def initialize(first, last)
    stations = [first, last]  
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

class Station
  attr_accessor :trains, :station_name

  def initialize(station_name)
    trains = []
  end

  def arrived_train(train)
    trains.push(train)
  end

  def departed_train(train)
    trains.delete(train)
  end

  def trains_here
    trains.each { |train| puts train }
  end

  def trains_by_type(type)
    trains.select { |t| type == @type }
  end

end

class Train
  attr_reader :speed, :route, :curr_station, :wagons, :number, :type

  def initialize(number.to_s, type, wagons)
    @type = type
    @wagons = wagons.to_i
    @speed = 0
  end

  def wagons_quantity
    puts @wagons
  end

  def speed_status
    puts @speed
  end

  def speed_up
    loop do
      @speed += 1
    break if @speed >= 60
    end
  end

  def speed_break
    loop do
      @speed -= 1
    break if @speed == 0
    end
  end

  def attach_wagon
    @wagons += 1 if @speed == 0
  end

  def detach_wagon
    @wagons -= 1 if @speed == 0
  end

  def route_accept(route)
    @route = route.stations
    @curr_station_index = 0
    @curr_station = route.stations_list[0]
    Station.train_arrive(self)
  end

  def move_forward
    @curr_station_index += 1
  end

  def move_back
    @curr_station_index -= 1
  end

  def train_status
    puts "Текущая станция: #{route.stations[@curr_station_index]}."
    puts "Предыдущая станция: #{route.stations[@curr_station_index - 1]}."
    puts "Следующая станция: #{route.stations[@curr_station_index + 1]}."
  end

 end
 