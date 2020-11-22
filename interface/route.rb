require_relative 'instance_counter.rb'

class Route
  attr_reader :stations

  include InstanceCounter

  def initialize(start_station, finish_station)
    validate!
    @stations = [start_station, finish_station]
  end

  def validate!
    raise "Need to add 2 stations" if @stations.size < 2
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
