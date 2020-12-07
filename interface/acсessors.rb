module Accessors

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def attr_accessor_with_history(*methods)
      methods.each do |method|

        raise TypeError.new("method name is not symbol") unless method.is_a?(Symbol)

        define_method(method) do
          instance_variable_get("@#{method}")
        end

        define_method("#{method}=") do |v|
          history ||= []
          history << v
          instance_variable_set("@#{method}_history", history)
          instance_variable_set("@#{method}", v)
        end

        define_method("#{method}_history") do
          instance_variable_get("@#{method}_history")
        end
      end

      def strong_attr_accessor(name, class_type)

        raise TypeError.new("Method name is not symbol") unless method.is_a?(Symbol)

        define_method(name) do
          instance_variable_get("@#{name}")
        end

        define_method("#{name}=") do |v|
          raise "Variable value and variable type do not match" if v.is_a?(class_type)
          instance_variable_set("@#{name}", v)
        end
      end
    end
  end
end
