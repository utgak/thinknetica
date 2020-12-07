require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

class Train
  attr_reader :number, :type, :route
  attr_accessor :station, :speed, :carriages

  include InstanceCounter
  include Manufacturer
  include Validation

  @@trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = {}
    @speed = 0
    @@trains[number] = self
    validate!
  end

  validate @number, :presence
  validate @number, :format, /([a-z]|\d){3}-?([a-z]|\d){2}$/i

  def each_carriage(block)
    return unless block_given?

    @carriages.each_pair do |number,carriage|
      block.call(number,carriage)
    end
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
    carriage_number ||= 0
    if self.speed == 0 && self.type == carriage.type
      carriage_number += 1
      carriages[carriage_number] = carriage
    end
  end

  def remove_carriage(number)
    if self.speed == 0 && carriages.size != 0
      carriages.delete(number)
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
    else
      false
    end
  end

  def move_previous_station
    if route.stations.index(station) != 0
      self.station = previous_station
    else
      false
    end
  end
end
