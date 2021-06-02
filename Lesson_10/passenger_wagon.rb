require_relative 'wagon'
require_relative 'module_manufacturer'

class PassengerWagon < Wagon
  include Validation

  attr_reader :total_seats, :taken_seats
  validate :total_seats, :type, Integer

  def initialize(total_seats)
    @total_seats = total_seats
    @taken_seats = 0
    validate!
    @type = :passenger
  end

  def buy_seat
    raise 'Все места уже заняты' if total_seats == taken_seats
    self.taken_seats += 1
  end

  def free_seats
    total_seats - taken_seats
  end

  protected

  attr_writer :total_seats, :taken_seats
end
