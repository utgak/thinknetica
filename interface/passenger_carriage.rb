class PassengerCarriage < Carriage
  def initialize(space)
    @type = :passenger
    @space = space
  end

  def fill_the_space
    self.filled_space += 1
  end
end
