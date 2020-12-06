class CLI
    def start #clear existing lists, display intro, request input of distance, compares to keywords, else -> send to Navigator.user_start
        Api_Sorter.clear
        Exoplanets.clear
        intro
        Navigator.user_start
    end

    def self.systems_within_distance(systems) #displays formatted list of star system names, get input for specific system or back/exit/restart
        puts ""
        sleep(0.6)
        puts "I found #{systems.size} known Star System(s) totaling #{Api.data_size} exoplanet(s) within #{Navigator.distance} parsec(s): "
        puts "---------------------------------------------"
        sleep(2)
        puts ""

        if systems.size < 41
            systems.each_with_index do |system, index|
                sleep (0.1)
                puts "  [#{index + 1}]  #{system}"
            end
        else
            systems.each_with_index do |system, index|
                puts "  [#{index + 1}]  #{system}"
            end
        end
        
        puts ""
        puts ""
        puts ""
        if systems.size == 0 #safegaurd against getting stuck if 0 systems are returned
            puts "Try another distance."
            puts ""
            Navigator.user_start
        else
            puts "Type the name or number of a star system to see more details. " #input for more details on star system
            puts ""
            name = gets.chomp
            Navigator.system(name)
        end
    end

    def self.system(name, data) #receives from Exoplanets. Nicely displays data. Allows for [back], [exit], or [restart] inputs. 3 tries to input correctly or restarts program
        puts ""
        puts ""
        puts "------------------"
        puts "  #{name}  "
        puts "------------------"
        sleep (0.25)
        puts "    Mass: #{data[:mass]} Suns "
        sleep (0.1)
        puts "    Size: #{data[:size]} Sun radii "
        sleep (0.1)
        puts "    Temperature: #{data[:temp]} K "
        sleep (0.1)
        puts "    Distance: #{data[:dist]} parsecs "
        sleep (0.1)
        puts "    Number of Exoplanets: #{data[:exoplanets]} "
        sleep (0.1)
        data["planet_names"].sort.each_with_index do |planet, index|
            puts "               #{index + 1}. #{planet}"
        end
        puts "------------------"
        puts ""
        sleep (0.1)
        puts "Go [back] or [exit]."
        Navigator.end_of_line
    end

    def self.end
        puts ""
        puts ""
        puts ""
        puts "---------------"
        puts "  Goodbye!"
        puts "---------------"
        puts ""
        puts ""
        puts ""
        sleep(1)
        exit
    end
end 