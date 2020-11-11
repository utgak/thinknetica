require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require_relative 'cargo_train'

def main_interface
  puts(
"Select an action:
1. Create trains
2. Create routes and manage stations in it
3. Assign a route to a train
4. Add wagons to the train
5. Disconnect wagons from the train
6. Move the train along the route forward and backward
7. View station list and train list at station"
  )
  loop do
    option = gets.chomp.to_i
    case option
    when 1
      create_train
    when 2
      create_routes_and_manage_stations_in_it
    when 3
      assign_a_route_to_a_train
    when 4
      add_carriage_to_the_train
    when 5
      disconnect_wagons_from_the_train
    when 6
      move_the_train_along_the_route_forward_and_backward
    when 7
      view_station_list_and_train_list_at_station
    else
      exit(0)
    end
  end
end

def create_train
  puts(
"Select an action:
1. Cargo train
2. Passenger train"
  )
  option = gets.chomp.to_i
  case option
  when 1
    puts("Enter train number")
    number = gets.chomp
    @train = new.CargoTrain(number)
  when 2
    puts("Enter train number")
    number = gets.chomp
    @train = new.PassengerTrain(number)
  else
    main_interface
  end
  main_interface
end

def create_routes_and_manage_stations_in_it
  puts(
"Select an action:
1. Create route
2. Add intermediate station
3. Delete station"
  )
  option = gets.chomp.to_i
  case option
  when 1
    puts("Enter start station")
    start_station = gets.chomp
    puts("Enter finish station")
    finish_station = gets.chomp
    @route = new.Route(start_station, finish_station)
  when 2
    puts("Enter station name")
    sta_name = gets.chomp
    @route.add_station(sta_name)
  when 3
    puts("Enter station name")
    sta_name = gets.chomp
    @route.delete_station(sta_name)
  else
    main_interface
  end
  main_interface
end

def assign_a_route_to_a_train
  @train.route(@route)
  main_interface
end

def add_carriage_to_the_train
  if @train.type == :cargo
    carriage = CargoCarriage.new(:cargo)
  else
    carriage = PassengerCarriage.new(:passenger)
  end
  @train.add_carriage(carriage)
  main_interface
end

def disconnect_wagons_from_the_train
  carriage = @train.carriages.last
  @train.remove_carriage(carriage)
  main_interface
end

def move_the_train_along_the_route_forward_and_backward
  puts(
"Select an action:
1. Move forward
2. Move back"
  )
  option  = gets.chomp
  case option
  when 1
    @train.move_next_station
  when 2
    @train.move_previous_station
  else
    main_interface
  end
  main_interface
end

def view_station_list_and_train_list_at_station
  puts(
      "Select an action:
1. View station list
2. View train list at station"
  )
  option = gets.chomp
  case option
  when 1
    stations = Route.stations
    puts(stations)
  when 2
    Route.stations.each do |station|
      puts "Станция: #{station.name}"
      puts "Пассажирские поезда:"
      station.trains_by_type(:passenger).each { |train| puts "Поезд: #{train.number}" }
      puts "Грузовые поезда:"
      station.trains_by_type(:cargo).each { |train| puts "Поезд: #{train.number}" }
    end
  else
    main_interface
end
main_interface
end
