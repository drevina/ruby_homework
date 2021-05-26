require_relative "wagon"
class CargoWagon < Wagon
  
    def initialize(volume)
      @volume = volume
      @type = :cargo
      @taken_space = 0
    end

    def load_goods(goods_volume)
      raise "Объём груза слишком большой, проверьте доступный объём для загрузки" if goods_volume > (volume - taken_space)
      taken_space - goods_volume
    end

    def display_taken_space
      taken_space
    end

    def display_free_space
      volume - taken_space
    end
end