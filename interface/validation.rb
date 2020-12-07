module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :args

    def validate(name, type, option = nil)
      @args ||= []
      @args << [name, type, option]
    end
  end

  module InstanceMethods
    def validate!
      (self.class.args.size/3).times do
        name = self.class.args.delete_at(0)
        type = self.class.args.delete_at(0)
        option = self.class.args.delete_at(0)

        case type
        when :presence
          presence(name)
        when :format
          format(name, option)
        when :type
          type(name, option)
        end
      end

      def type(name, type)
        raise 'The types do not match' unless name.is_a?(type)
      end

      def presence(name)
        raise "Empty input" if name.nil? or name == ""
      end

      def format(name, format)
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
