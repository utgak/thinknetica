require_relative 'instance_counter.rb'

class Route
  attr_reader :stations

  include InstanceCounter

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
