class Carriage
  attr_reader :type, :filled_space, :space

  include Manufacturer

  def initialize(type,space)
    @type = type
    @space = space
  end

  def free_space
    @space - @filled_space
  end

end
