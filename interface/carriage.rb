class Carriage
  attr_reader :type, :filled_space, :space

  include Manufacturer
  include Validation

  def initialize(type,space)
    @type = type
    @space = space
    validate!
  end

  validate :space, :presence

  def free_space
    @space - @filled_space
  end

end
