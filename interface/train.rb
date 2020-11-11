class Train
  attr_reader :number, :type, :route
  attr_accessor :station, :speed, :carriages

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
  end

  def raise_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_carriage(carriage)
    if self.speed == 0 && (self.type = Carriage.type)
      carriages << carriage
    else
      puts "You cannot add carriage while the train is moving"
    end
  end

  def remove_carriage(carriage)
    if self.speed == 0 && carriages.size != 0
      carriages.delete(carriage)
    else
      puts "You cannot remove carriage while the train is moving"
    end
  end

  def route=(route)
    @route = route
    self.station = route.stations.first
  end

  def next_station
    if route.stations.index(station) < route.stations.size
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
    if route.stations.index(station) < route.stations.size
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
