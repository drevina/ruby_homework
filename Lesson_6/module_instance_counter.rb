module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end
  end

  protected 
  
  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end
  end

end