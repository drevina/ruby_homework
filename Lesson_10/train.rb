require_relative 'module_manufacturer'
require_relative 'module_instance_counter'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :speed, :route, :curr_station, :wagons, :number, :type
  validate :number, :format, /^[\w\d]{3}-?[\w\d]{2}$/

  @@all_trains = []
  TRAIN_TYPE = [cargo: 'cargo', passenger: 'passenger'].freeze

  def self.find(number)
    if @@all_trains.include? number
      @@all_trains[number]
    else
      puts 'Такого поезда не существует'
    end
  end

  def initialize(number, type)
    @number = number
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
      break if speed.zero?
    end
  end

  def attach_wagon(wagon_type)
    validate_type_wagon!(wagon_type)
    wagons << wagon_type if speed.zero?
  end

  def detach_wagon
    wagons.delete(wagon_type) if speed.zero?
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
    puts "Предыдущая станция: #{route[previous_station_index]}."
    puts "Следующая станция: #{route[next_station_index]}."
  end

  def all_wagons
    wagons.each { |w| puts w }
  end

  def wagons_block
    wagons.each { |wagon| yield(wagon) }
  end

  protected

  attr_accessor :curr_station_index, :wagon_type
  attr_writer :curr_station, :route, :type

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

end
