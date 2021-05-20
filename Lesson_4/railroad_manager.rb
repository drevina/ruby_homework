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

class Train
  attr_accessor :speed, :route, :curr_station, :wagons, :number, :type, :curr_station_index

  def initialize(number, type, wagons)
    @number = number.to_s
    @type = type
    @wagons = wagons.to_i
    @speed = 0
  end

  def wagons_quantity
    puts "Этот поезд имеет: #{wagons} вагон(ов)."
  end

  def speed_status
    puts "Текущая скорость поезда: #{speed}."
  end

  def speed_up
    loop do
      self.speed += 1
    break if speed >= 60
    end
  end

  def speed_break
    loop do
      self.speed -= 1
    break if speed == 0
    end
  end

  def attach_wagon
    self.wagons += 1 if speed == 0
  end

  def detach_wagon
    self.wagons -= 1 if speed == 0
  end

  def route_accept(route)
    self.route = route.stations
    self.curr_station_index = 0
    self.curr_station = route.stations_list.first
    curr_station.arrived_train(self)
  end

  def move_forward
    self.curr_station_index += 1
  end

  def move_back
    self.curr_station_index -= 1
  end

  def train_status
    puts "Текущая станция: #{route[curr_station_index]}."
    puts "Предыдущая станция: #{route[self.curr_station_index - 1]}."
    puts "Следующая станция: #{route[self.curr_station_index + 1]}."
  end

 end
 