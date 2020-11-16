require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

class Train
  attr_reader :number, :type, :route
  attr_accessor :station, :speed, :carriages

  include InstanceCounter
  include Manufacturer

  @@trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    @@trains[number] = self
  end

  def self.find(number)
    @@trains[number]
  end

  def raise_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_carriage(carriage)
    if self.speed == 0 && (self.type = carriage.type)
      carriages << carriage
    end
  end

  def remove_carriage(carriage)
    if self.speed == 0 && carriages.size != 0
      carriages.delete(carriage)
    end
  end

  def route=(route)
    @route = route
    self.station = route.stations.first
  end

  def next_station
    if route.stations.index(station) < route.stations.size
      route.stations[route.stations.index(station) + 1]
    end
  end

  def previous_station
    if route.stations.index(station) != 0
      route.stations[route.stations.index(station) - 1]
    end
  end

  def move_next_station
    if route.stations.index(station) < route.stations.size - 1
      self.station = next_station
    else -1
    end
  end

  def move_previous_station
    if route.stations.index(station) != 0
      self.station = previous_station
    else -1
    end
  end
end
