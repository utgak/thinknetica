require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'manufacturer.rb'

class Main

  def main_interface
    puts(
  "Select an action:
  1. Create trains
  2. Create routes and manage stations in it
  3. Assign a route to a train
  4. Add wagons to the train
  5. Disconnect wagons from the train
  6. Move the train along the route forward and backward
  7. View station list and train list at station
  8. Show the next previous or current station on the route
  9. add_or_delete_stations"
    )
    loop do
      option = gets.chomp.to_i
      case option
      when 1
        create_train
      when 2
        create_route
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
      when 8
        show_the_next_previous_or_current_station_on_the_route
      when 9
        add_or_delete_stations
      else
        exit(0)
      end
    end
  end

  private

  def create_train
    puts(
  "Select an action:
  1. Cargo train
  2. Passenger train"
    )
    option = gets.chomp.to_i
    begin
      puts("Enter train number")
      number = gets.chomp
      case option
      when 1
        @train = CargoTrain.new(number)
      when 2
        @train = PassengerTrain.new(number)
      end
      if @train.valid? == true
        test = true
      end
      puts("Train successfully created")
    rescue
      if test == false
        puts("Number has invalid format")
        retry
      end
    end
  end

  def create_route
    option = gets.chomp.to_i
    case option
    when 1
      puts("Enter start station")
      start_station = gets.chomp
      puts("Enter finish station")
      finish_station = gets.chomp
      @route = Route.new(start_station, finish_station)
    when 2
      puts("Enter station name")
      sta_name = gets.chomp
      @route.add_station(sta_name)
    when 3
      puts("Enter station name")
      sta_name = gets.chomp
      @route.delete_station(sta_name)
    end
  end

  def add_or_delete_stations
    puts(
        "Select an action:
  1. Add intermediate station
  2. Delete station"
    )
    option = gets.chomp.to_i
    case option
    when 1
      puts("Enter station name")
      sta_name = gets.chomp
      @route.add_station(sta_name)
    when 2
      puts("Enter station name")
      sta_name = gets.chomp
      @route.delete_station(sta_name)
    end
  end

  def assign_a_route_to_a_train
    @train.route(@route)
  end

  def add_carriage_to_the_train
    if @train.type == :cargo && @train.speed == 0
      carriage = CargoCarriage.new(:cargo)
      @train.add_carriage(carriage)
      elsif @train.type == :passenger && @train.speed == 0
      carriage = PassengerCarriage.new(:passenger)
      @train.add_carriage(carriage)
    else
      puts "You cannot add carriage while the train is moving"
    end
  end

  def disconnect_wagons_from_the_train
    if @train.speed == 0
      carriage = @train.carriages.last
      @train.remove_carriage(carriage)
    else
      puts "You cannot remove carriage while the train is moving"
    end
  end

  def move_the_train_along_the_route_forward_and_backward
    puts(
  "Select an action:
  1. Move forward
  2. Move back"
    )
    option  = gets.chomp.to_i
    case option
    when 1
      if @train.move_next_station != false
        @train.move_next_station
      else
        puts "Train at the terminal station."
      end
    when 2
      if @train.move_previous_station != false
        @train.move_previous_station
      else
        puts "Train at the initial station."
      end
    end
  end

  def view_station_list_and_train_list_at_station
    puts(
        "Select an action:
  1. View station list
  2. View train list at station"
    )
    option = gets.chomp.to_i
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
    end

    def show_the_next_previous_or_current_station_on_the_route
      puts(
          "Select an action:
  1. View previous station
  2. View current station
  3. View next station"
      )
      option = gets.chomp.to_i
      case option
      when 1
        if @train.route.stations.index(@train.station) != 0
          puts("The previous station is #{@train.previous_station}")
        else
          puts("Train at the initial station")
        end
      when 2
        puts("The current station is #{@train.station}")
      when 3
        if @train.route.stations.index(@train.station) < @train.route.stations.size - 1
          puts("The next station is #{@train.next_station}")
        else
          puts("Train at the terminal station")
        end
      end
    end
  end
end

main = Main.new
main.main_interface
