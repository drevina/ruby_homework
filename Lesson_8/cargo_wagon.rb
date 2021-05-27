require_relative "wagon"
class CargoWagon < Wagon

	attr_reader :taken_volume
  
    def initialize(volume)
      @volume = volume
      @type = :cargo
      @taken_volume = 0
    end

    def load_goods(volume)
      raise "Объём груза слишком большой, проверьте доступный объём для загрузки" if volume > free_volume
      self.taken_volume += volume
    end

    def free_volume
      self.volume - taken_volume
    end

    protected
    attr_accessor :volume
end