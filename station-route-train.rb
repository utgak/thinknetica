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


class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end


class Train
  attr_reader :number, :type, :route
  attr_accessor :station, :speed, :count

  def initialize(number, type, count)
    @number = number
    @type = type
    @count = count
    @speed = 0
  end

  def raise_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_carriage
    if self.speed == 0
      self.count += 1
    else
      puts "You cannot add carriage while the train is moving"
    end
  end

  def remove_carriage
    if self.speed == 0
      self.count -= 1
    else
      puts "You cannot remove carriage while the train is moving"
    end
  end

  def route=(route)
    @route = route
    self.station = route.stations.first
  end

  def next_station
    if route.stations.index(station) < route.stations.size - 1
      route.stations[route.stations.index(station) + 1]
    else puts "Train at the terminal station."
    end
  end

  def previous_station
    if route.stations.index(station) != 0
      route.stations[route.stations.index(station) - 1]
    else
      puts "Train at the initial station."
    end
  end

  def move_next_station
    if route.stations.index(station) < route.stations.size - 1
      self.station = route.stations[route.stations.index(station) + 1]
    else puts "Train at the terminal station."
    end
  end

  def move_previous_station
    if route.stations.index(station) != 0
      self.station = route.stations[route.stations.index(station) - 1]
    else
      puts "Train at the initial station."
    end
  end
end
