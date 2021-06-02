module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, valid_type, *args)
      self.validations ||= []
      self.validations << { name: name, valid_type: valid_type, args: args }
    end
  end

  module InstanceMethods
    def validate_presence(name, *args)
      raise "Name can't be empty!" if name.nil? || name.empty?
    end

    def validate_format(name, format, *args)
      raise "#{name} has invalid format!" if name !~ format
    end

    def validate_type(name, type, class_name)
      raise "Type doesn't match the specified class!" if type.class != class_name
    end

    def valid?
      validate!
      true
    rescue
      false
    end
    end

    def validate!
      self.class.validations.each do |key, value|
        name = key[:name]
        method_type = "validate_#{validations[:valid_type]}"
        send(method_type, name, validations[:args])
    end
  end
end
