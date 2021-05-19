class Route

	attr_accessor :route

	def initialize(first, last)
		@first = first
		@last = last
		@route = [@first, @last]	
	end


	def station_add(name)
		@name = name
		@route.insert(1, @name)
	end


	def station_del(name)
		@route.delete(name)
	end


	def route_list
		@route
	end		

end

class Station

  attr_accessor :trains, :station

  def initialize(station)
    @station = station
    @trains = []
  end

  def train_arrive(train)
    @trains.push(train)
  end

  def train_depart(train)
    @trains.delete(train)
  end

  def trains_now
  	puts @trains
  end

  def trains_by_type(type)
    @trains.select { |t| type == @type }
  end
end



class Train

  attr_reader :speed, :route, :curr_station, :wagons, :number, :type

  def initialize(number, type, wagons)
    @number = number.to_s
    @type = type
    @wagons = wagons.to_i
    @speed = 0
  end

  def wagons_qty
  	print @wagons
  end

  def speed_status
  	print @speed
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

  def attach
  	@wagons += 1 if @speed == 0
  end

  def detach
  	@wagons -= 1 if @speed == 0
  end

  def route_accept(route)
    @route = route.route
    @curr_station_index = 0
    @curr_station = route.route_list[0]
    Station.train_arrive(self)
  end

  def go
  	@curr_station_index += 1
  end

  def back
  	@curr_station_index -= 1
  end

  def train_status
  	puts "Текущая станция: #{route.route[@curr_station_index]}."
  	puts "Предыдущая станция: #{route.route[@curr_station_index - 1]}."
  	puts "Следующая станция: #{route.route[@curr_station_index + 1]}."
  end
 end
 