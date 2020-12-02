class CLI
    def start
        Api_Sorter.clear
        Exoplanets.clear
        puts ""
        puts ""
        puts "  *****************************************************************************************"
        puts "  |  Welcome to the Comprehensive-ish List Interpreter for NASA's Exoplanetary Database!  |"
        puts "  |  Here you can browse known star systems and their exoplanets by distance from Earth.  |"
        puts "  *****************************************************************************************"
        puts ""
        sleep(0.25)
        puts "How many parsecs would you like to browse? "
        puts ""
        @@distance = gets.chomp
        @@distance == "exit" ? CLI.end : false
        @@distance == "restart" ? start.new : false
        Navigator.user_start(@@distance)
    end
    def self.systems_within_distance(systems)
        if systems.size == 1
            g = "is"
            s = ""
        else 
            g = "are"
            s = "s"
        end
        if @@distance == 1
            p = ""
        else 
            p = "s"
        end
        puts ""
        sleep(0.6)
        puts "There #{g} #{systems.size} known Star System#{s} within #{@@distance} parsec(s): "
        puts "---------------------------------------------"
        puts ""
        systems.each_with_index do |system, index|
            sleep (0.1)
            puts "  [#{index + 1}]  #{system}"
        end
        puts ""
        puts ""
        puts ""
        if systems.size == 0
            puts "Try another distance."
            puts ""
            @@distance = gets.chomp
            Navigator.user_start(@@distance)
        else
            puts "Type the name of a star system to see more details. "
            puts ""
            name = gets.chomp
            Navigator.system(name)
        end
    end
    def self.back
    end
    def self.system(name, data)
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
            puts "               [#{index + 1}] #{planet}"
        end
        puts "------------------"
        puts ""
        sleep (0.1)
        puts "Go [back] or [exit]."
        new_input = gets.chomp
        new_input == "restart" ? CLI.new.start : false
        if new_input == "back"
            CLI.systems_within_distance(Exoplanets.names)
        elsif new_input == "exit"
            CLI.end
        else
            puts "Command not understood. For testing purposes I'll just restart."
            CLI.new.start
        end 
    end
    def self.distance
        @@distance
    end
    def self.end
        puts ""
        puts ""
        puts ""
        puts "---------------"
        puts "Goodbye!"
        puts "---------------"
        puts ""
        puts ""
        puts ""
        sleep(1)
        exit
    end
end 