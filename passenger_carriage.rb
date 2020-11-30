class PassengerCarriage < Carriage

  attr_reader :space, :filled_space

  def initialize(space)
    @type = :passenger
    @space = space
  end

  def fill_the_space
    self.filled_space += 1
  end
end
