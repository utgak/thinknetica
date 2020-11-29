class PassengerCarriage < Carriage

  attr_reader :space, :filled_space

  def initialize(type,space)
    @type = type
    @space = space
  end

  def fill_the_space
    self.filled_space += 1
  end

  def free_space
    @space - @filled_space
  end
end
