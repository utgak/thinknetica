class Station
  attr_reader :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
  end

  def trains_by_type(type)
    train_type = []
    self.trains.each do |train|
      if train.type == type
        train_type << train
      end
    end
    train_type
  end
end

