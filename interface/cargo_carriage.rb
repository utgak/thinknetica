class CargoCarriage < Carriage

  attr_reader :space, :filled_space

  def initialize(space)
    @type = :cargo
    @space = space
  end

  def fill_the_space(space)
    self.filled_space += space
  end
end
