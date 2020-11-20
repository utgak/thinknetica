class Carriage
  attr_reader :type

  include Manufacturer

  def initialize(type)
    @type = type
  end
end
