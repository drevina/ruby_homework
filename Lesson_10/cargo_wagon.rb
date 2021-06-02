require_relative 'wagon'

class CargoWagon < Wagon
  include Validation

  attr_reader :taken_volume, :volume
  validate :volume, :type, Float

  def initialize(volume)
    @volume = volume
    validate!
    @type = :cargo
    @taken_volume = 0
  end

  def load_goods(volume)
    raise 'Объём груза слишком большой, проверьте доступный объём для загрузки' if volume > free_volume
    self.taken_volume += volume
  end

  def free_volume
    volume - taken_volume
  end

  protected

  attr_writer :volume
end
