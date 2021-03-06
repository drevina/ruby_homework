require_relative 'module_manufacturer'
require_relative 'module_instance_counter'
class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :speed, :route, :curr_station, :wagons, :number, :type

  @@all_trains = []
  TRAIN_TYPE = ["cargo", "passenger"]

  def self.find(number)
    if @@all_trains.include? number
      @@all_trains[number]
    else
      puts "Такого поезда не существует"
    end
  end

  def initialize(number, type)
    @number = number.to_s
    @type = type
    validate!
    @wagons = []
    @speed = 0
    @@all_trains << self.number
    register_instance
    puts "Был создан поезд номер #{number} типа #{type}."
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

  def attach_wagon(wagon)
    validate_type_wagon!(wagon)
    wagons << wagon if speed == 0
  end

  def detach_wagon
    wagons.delete(wagon) if speed == 0
  end

  def route_accept(route)
    self.route = route
    self.curr_station_index = 0
    self.curr_station = route.stations_list.first
    curr_station.arrived_train(self)
  end

  def move_forward
    curr_station.departed_train(self)
    next_station.arrived_train(self)
    self.curr_station = next_station
    self.curr_station_index = next_station_index
  end

  def move_back
    curr_station.departed_train(self)
    previous_station.arrived_train(self)
    self.curr_station = previous_station
    self.curr_station_index = previous_station_index
  end

  def train_status
    puts "Текущая станция: #{route[curr_station_index]}."
    puts "Предыдущая станция: #{route[self.previous_station_index]}."
    puts "Следующая станция: #{route[self.next_station_index]}."
  end

  def valid_train_data?
    validate!
    true
  rescue
    false
  end

  protected
    attr_accessor :curr_station_index, :curr_station, :wagon, :type, :route

    #отделила эти методы, чтобы извне можно было переместить поезд только через метод move_ на 1 станцию
    #так как до этого текущая/предыдущая/следущая станции были сеттерами (а все методы публичными)
    #и по идее можно было задать извне перемещение на любое кол-во станций

  def next_station
    route.stations[next_station_index]
  end

  def previous_station
    route.stations[previous_station_index]
  end

  def next_station_index
    curr_station_index + 1
  end

  def previous_station_index
    curr_station_index - 1
  end

  def validate_type_wagon!(wagon)
    raise "Вагон не подходит по типу к поезду, невозможно прицепить" if wagon.type == type
  end

  def validate!
    raise "Неверный формат номера поезда" if number !~ /^[\w\d]{3}-?[\w\d]{2}$/
    raise "Поезд может быть только типа cargo или passenger" unless TRAIN_TYPE.include?(type)
  end
 end