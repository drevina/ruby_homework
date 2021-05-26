require_relative "wagon"
require_relative "module_manufacturer"
class PassengerWagon < Wagon

  attr_reader :total_seats, :taken_seats

  def initialize(total_seats)
    @type = :passenger
    @total_seats = total_seats
    @taken_seats = 0
  end

  def buy_seat
    raise "Все места уже заняты" if total_seats == taken_seats
    self.taken_seats += 1
  end

  def display_taken_seats
    taken_seats
  end

  def display_free_seats
    total_seats - taken_seats
  end

  protected
  attr_writer :total_seats, :taken_seats

end