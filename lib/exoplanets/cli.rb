class CLI
    def start #clear existing lists, display intro, request input of distance, compares to keywords, else -> send to Navigator.user_start
        Api_Sorter.clear
        Exoplanets.clear
        puts ""
        puts ""
        puts ""
        puts "     NNNNNNNN        NNNNNNNN               AAA                  SSSSSSSSSSSSSSS                AAA"               
        puts "     N:::::::N       N::::::N              A:::A               SS:::::::::::::::S              A:::A"              
        puts "     N::::::::N      N::::::N             A:::::A             S:::::SSSSSS::::::S             A:::::A"             
        puts "     N:::::::::N     N::::::N            A:::::::A            S:::::S     SSSSSSS            A:::::::A"            
        puts "     N::::::::::N    N::::::N           A:::::::::A           S:::::S                       A:::::::::A"           
        puts "     N:::::::::::N   N::::::N          A:::::A:::::A          S:::::S                      A:::::A:::::A"          
        puts "     N:::::::N::::N  N::::::N         A:::::A A:::::A          S::::SSSS                  A:::::A A:::::A"         
        puts "     N::::::N N::::N N::::::N        A:::::A   A:::::A          SS::::::SSSSS            A:::::A   A:::::A"        
        puts "     N::::::N  N::::N:::::::N       A:::::A     A:::::A           SSS::::::::SS         A:::::A     A:::::A"       #<--This is so f$cking sick
        puts "     N::::::N   N:::::::::::N      A:::::AAAAAAAAA:::::A             SSSSSS::::S       A:::::AAAAAAAAA:::::A"      
        puts "     N::::::N    N::::::::::N     A:::::::::::::::::::::A                 S:::::S     A:::::::::::::::::::::A"     
        puts "     N::::::N     N:::::::::N    A:::::AAAAAAAAAAAAA:::::A                S:::::S    A:::::AAAAAAAAAAAAA:::::A"    
        puts "     N::::::N      N::::::::N   A:::::A             A:::::A   SSSSSSS     S:::::S   A:::::A             A:::::A"   
        puts "     N::::::N       N:::::::N  A:::::A               A:::::A  S::::::SSSSSS:::::S  A:::::A               A:::::A"  
        puts "     N::::::N        N::::::N A:::::A                 A:::::A S:::::::::::::::SS  A:::::A                 A:::::A" 
        puts "     NNNNNNNN         NNNNNNNAAAAAAA                   AAAAAAA SSSSSSSSSSSSSSS   AAAAAAA                   AAAAAAA"
        puts ""
        puts ""
        puts "              *****************************************************************************************"
        puts "              |  Welcome to the Comprehensive-ish List Interpreter for NASA's Exoplanetary Database!  |"
        puts "              |  Here you can browse known star systems and their exoplanets by distance from Earth.  |"
        puts "              *****************************************************************************************"
        puts ""
        sleep(0.25)
        puts "How many parsecs would you like to browse? "
        puts ""
        @@distance = gets.chomp
        @@distance == "exit" ? CLI.end : false
        @@distance == "restart" ? start.new : false
        Navigator.user_start(@@distance)
    end

    def self.systems_within_distance(systems) #displays formatted list of star system names, get input for specific system or back/exit/restart
        if systems.size == 1
            g = "is"
            s = ""
        else 
            g = "are"
            s = "s"
        end

        if Navigator.size == 1
            e = ""
        else
            e = "s"
        end

        if @@distance == 1
            p = ""
        else 
            p = "s"
        end

        puts ""
        sleep(0.6)
        puts "There #{g} #{systems.size} known Star System#{s} totaling #{Navigator.size} exoplanet#{e} within #{@@distance} parsec#{p}: "
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
            @@distance = gets.chomp
            Navigator.user_start(@@distance)
        else
            puts "Type the name of a star system to see more details. " #input for more details on star system
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
        new_input = gets.chomp
        attempts = 0
        while attempts < 2
            new_input == "restart" ? CLI.new.start : false
            new_input == "back" ? CLI.systems_within_distance(Exoplanets.names) : false
            new_input == "exit" ? CLI.end : false
            puts ""
            puts "Command not understood. Please try again."
            puts ""
            attempts += 1
            new_input = gets.chomp   
        end

        puts ""
        puts "Command not understood. Attempts exceeded. Restarting.."
        sleep(1)
        CLI.new.start
    end

    def self.distance #used in Navigator.system
        @@distance
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