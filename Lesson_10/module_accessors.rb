module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |name|
      define_method(name) { instance_variable_get("@#{name}".to_sym) }
      define_method("@#{name}=".to_sym) do |value|
        instance_variable_set("@#{name}".to_sym, value) end
      define_method("@#{name}_history_get") { instance_variable_get("@#{name}_history") }
      define_method("@#{name}_history_set".to_sym)
        var_history = []
        instance_variable_set("@#{name}_history".to_sym, value)
        var_history << value end
  end

  def strong_attr_accessor(name, class_name)
    define_method(name) { instance_variable_get("@#{name}".to_sym) }

    define_method("@#{name}=".to_sym) do |value|
      instance_variable_set("@#{name}".to_sym, value) if name.class == class_name
      raise StandartError "Invalid class!" end
  end
end
