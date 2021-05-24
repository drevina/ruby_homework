require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'module_manufacturer'
require_relative 'module_instance_counter'

@all_stations_list = []
@all_routes = []
@all_trains_list = []

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
  11. Просмотреть количество поездов на станции
  12. Выход"
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
  display_trains_on_station if answer == 11
  exit if answer == 12
  start
end

def create_station
  puts "Введите название станции:"
  station_name = gets.chomp
  @all_stations_list << Station.new(station_name)
end

def create_train
  puts "Какого типа поезд вы хотите создать?
  1. Грузовой
  2. Пассажирский"
  answer_type = gets.chomp.to_i
  puts "Введите номер нового поезда:"
  number = gets.chomp.to_i
  @all_trains_list << CargoTrain.new(number) if answer_type == 1
  @all_trains_list << PassengerTrain.new(number) if answer_type == 2
end

def create_route
  puts 'Задайте начальную станцию:'
  first = gets.chomp
  puts 'Задайте конечную станцию:'
  last = gets.chomp
  @all_routes << Route.new(first, last)
end

def add_station_to_route
  puts "Введите название станции, которую хотите добавить в маршрут:"
  add_station = gets.chomp
  @all_routes&.add_station(add_station)
end

def delete_station_from_route
  puts 'Введите название станции, которую хотите удалить из маршрута:'
  delete_station = gets.chomp
  @all_routes&.delete_station(delete_station)
end

def set_route_to_train
  puts "Введите номер поезда, который хотите отправить на маршрут:"
  train = gets.chomp.to_s
  train&.route_accept(@all_routes) if @all_trains_list.include? train
end

def attach_wagon_to_train
  puts "Введите номер поезда, к которому хотите присоединить вагон:"
  attach_for_train = gets.chomp.to_s
  wagon = attach_for_train&.type == "passenger"? PassengerWagon.new : CargoWagon.new
  attach_for_train&.attach_wagon(wagon)
end

def detach_wagon_from_train
  puts "Введите номер поезда, от которого нужно отцепить вагон:"
  detach_from_train = gets.chomp.to_s
  detach_from_train&.detach_wagon
end

def move_forward
  puts "Введите номер поезда, который хотите переместить вперёд:"
  forward = gets.chomp.to_s
  forward&.move_forward
end

def move_back
  puts "Введите номер поезда, который хотите переместить назад:"
  back = gets.chomp.to_s
  back&.move_back
end

def print_stations_list
  @all_stations_list.each_with_index do |station, index|
    puts "#{index + 1}. #{station.station_name}"
  end
end

def print_trains_list
  @all_trains_list.each_with_index do |train, index|
    puts "#{index + 1}. #{train.number}"
  end
end

def print_trains_list_on_station
  puts "Введите название станции:"
  station_trains_here = gets.chomp
  result = @all_stations_list[station_trains_here]
  puts result
end

start