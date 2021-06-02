require_relative 'module_manufacturer'
require_relative 'module_instance_counter'
require_relative 'module_validation'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'passenger_train'

@all_stations_list = []
@all_routes = []
@all_trains_list = []
@attempt = 0

def start
  puts "Добрый день! Введие номер действия, которое хотите совершить:
  1. Создать станцию
  2. Создать поезд
  3. Создать маршрут
  4. Добавить станцию к маршруту
  5. Удалить станцию из маршрута
  6. Назначить маршрут поезду
  7. Добавить вагон поезду
  8. Отцепить вагон от поезда
  9. Переместить поезд по маршруту
  10. Просмотреть список станций
  11. Просмотреть список и количество поездов на станции
  12. Просмотреть список вагонов у поезда
  13. Занять место в вагоне
  14. Выход"
  answer = gets.chomp.to_i
  action(answer)
end

def action(answer)
  create_station if answer == 1
  create_train if answer == 2
  create_route if answer == 3
  add_station_to_route if answer == 4
  delete_station_from_route if answer == 5
  get_route_to_train if answer == 6
  attach_wagon_to_train if answer == 7
  detach_wagon_from_train if answer == 8
  move_train_on_route if answer == 9
  display_stations_list if answer == 10
  display_trains_list_on_station if answer == 11
  display_train_wagons if answer == 12
  take_place if answer == 13
  exit if answer == 14
  start
end

def create_station
  puts 'Введите название станции:'
  station_name = gets.chomp
  @all_stations_list << Station.new(station_name)
rescue StandardError => e
  puts e.message
  @attempt += 1
  retry if @attempt < 3
end

def create_train
  puts 'Введите номер нового поезда:'
  number = gets.chomp.to_s
  puts "Какого типа поезд вы хотите создать?
  1. Грузовой (введите cargo)
  2. Пассажирский (введите passenger)"
  answer_type = gets.chomp.to_s
  if answer_type == 'cargo'
    @all_trains_list << CargoTrain.new(number)
  elsif answer_type == 'passenger'
    @all_trains_list << PassengerTrain.new(number)
  else
    raise 'Невозможно создать поезд такого типа. Попробуйте снова'
    create_train
  end
rescue StandardError => e
  puts e.message
  @attempt += 1
  retry if @attempt < 3
end

def create_route
  puts 'Задайте начальную станцию:'
  first = gets.chomp
  puts 'Задайте конечную станцию:'
  last = gets.chomp
  @all_routes << Route.new(first, last)
end

def add_station_to_route
  puts 'Введите название станции, которую хотите добавить в маршрут:'
  name = gets.chomp
  @route.add_station(name)
end

def delete_station_from_route
  puts 'Введите название станции, которую хотите удалить из маршрута:'
  delete_station = gets.chomp
  @all_routes.delete_station(delete_station)
end

def set_route_to_train
  puts 'Введите номер поезда, который хотите отправить на маршрут:'
  train = gets.chomp.to_s
  train.route_accept(@all_routes) if @all_trains_list.include? train
end

def attach_wagon_to_train
  puts 'Введите номер поезда, к которому хотите присоединить вагон:'
  attach_for_train = gets.chomp.to_s
  attach_for_train.type == 'passenger' ? puts('Введите число мест:') : puts('Введите объём:')
  value = gets.chomp
  attach_for_train.type == 'passenger' ? PassengerWagon.new(value) : CargoWagon.new(value)
  attach_for_train.attach_wagon(wagon_type)
end

def detach_wagon_from_train
  puts 'Введите номер поезда, от которого нужно отцепить вагон:'
  detach_from_train = gets.chomp.to_s
  detach_from_train.detach_wagon
end

def move_forward
  puts 'Введите номер поезда, который хотите переместить вперёд:'
  forward = gets.chomp.to_s
  forward.move_forward
end

def move_back
  puts 'Введите номер поезда, который хотите переместить назад:'
  back = gets.chomp.to_s
  back.move_back
end

def display_stations_list
  @all_stations_list.each { |station| puts station.station_name.to_s }
end

def display_trains_list_on_station
  puts 'Введите название станции:'
  station_trains_here = gets.chomp
  result = @all_stations_list[station_trains_here]
  result2 = @all_stations_list[station_trains_here].size
  puts result
  puts "На станции #{result2} поездов."
end

def display_train_wagons
  puts 'Введите номер поезда:'
  train_wagons = gets.chomp.to_s
  train_wagons.all_wagons.each { |w| puts w }
end

def take_place
  puts 'Введите номер поезда:'
  number_of_train = gets.chomp
  train_result = @all_trains_list[number_of_train]
  train_result.all_wagons
  puts 'Выберите вагон:'
  wagon_result = gets.chomp
  if train_result.type == 'passenger'
    wagon_result.buy_seat
  else
    wagon_result.load_goods
  end
end

start
