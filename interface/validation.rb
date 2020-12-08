module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :args

    def validate(name, type, option = nil)
      @args ||= []
      @args << {:name => name, :type => type, :option => option}
    end
  end

  module InstanceMethods
    def validate!
      args.each do |val|
        send("validate_#{val[:type]}".to_sym, val[:name], val[:option])
      end

      def validate_type(name, type)
        raise 'The types do not match' unless name.is_a?(type)
      end

      def validate_presence(name)
        raise "Empty input" if name.nil? or name == ""
      end

      def validate_format(name, format)
        raise "Number has invalid format" if name !~ format
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end
