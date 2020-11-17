class Station
  attr_reader :name
  attr_reader :trains


  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations = {name => self}
  end

  def get_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
  end

  def trains_by_type(type)
    trains.filter { |train| train.type == type }
  end
end

