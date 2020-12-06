class Navigator
    
    @@size = 0

    def self.user_start #recieves distance input from CLI
        counter = 0
        @@distance = gets.chomp.downcase
        while @@distance.to_i == 0 
            @@distance == "exit" ? CLI.end : false
            @@distance == "restart" ? CLI.new.start : false #<--move from CLI.start
            if @@distance == "any number"
                dot_loop
                puts "Ok listen here smartass"
                dot_loop
                puts "Lets try this again"
                dot_loop
                CLI.new.start
            elsif @@distance == "help"
                puts ""
                puts "You can type exit, restart, or any number"
                user_start
            elsif counter == 2
                puts "Invalid input. Attempts exceeded. It was a pleasure almost serving you."
                CLI.end
            else
                puts "Invalid input. Please try again."
                counter += 1
                
            end
           @@distance = gets.chomp 
        end
            
        Api.get_data(@@distance) #pulls custom data from API, stores in Api instance variable
        
        @@size = Api.data_size 
        # # CLI.systems_within_distance(@@names)
        if @@distance.to_i < 10 #checks if data return will be very large. Either calls Api or double checks with user with size of set to be returned
            CLI.systems_within_distance(Api.names)
        else 
            puts ""
            puts "This will return #{Api.names.size} star systems. Are you sure you want to continue? [Y/N}"
            continue = gets.chomp.upcase
            until continue == "Y" || continue == "N" do
                puts ""
                puts "Please enter Y or N."
            end

            if continue == "Y" #call Api class to return data from API
                CLI.systems_within_distance(Api.names)
            else #restart w/ fancy counter for aesthetics
                puts ""
                puts "Ok, I'll send you back to the main screen to select a new distance."
                dot_loop
                CLI.new.start
            end
        end
    end

    def self.distance
        @@distance
    end
    def self.size
        @@size
    end
    
    def self.dot_loop
        looper = 0
        until looper == 3
            sleep(0.25)
            puts "."
            sleep(0.25)
            looper += 1
        end
    end

    def self.system(name) #checks name or index number for validity in current list. cool Interstellar easter egg. if wrong input x3 -> exit. else sends system name to Exoplanets
        tries = 0
        index_match = Api.names.size
        until Api.names.include?(name) || 0 < name.to_i && index_match >= name.to_i
            
            name == "exit" ? CLI.end : false
            name == "restart" || name == "back" ? CLI.new.start : false
            if name == "help"
                puts "You can type exit, restart, back or enter a name or number of a star system."
                system(gets.chomp)
            end

            if name == "gargantua"
                puts ""
                sleep(0.5)
                puts ".      `          .   .      `         *     .           ~         . .     *          .   __     .        *        "
                sleep(0.5)
                puts "        .       *  .       *                 .       *            .   .    `     . *   --(__)--          .         "
                sleep(0.5)
                puts "  'See you on the other side slick!!', Cooper shouts. *       .                .  *    ~ .                   "
                sleep(0.5)
                puts ".    *      .     ~     .          *.         .   *          ~     .                .          `      *      "
                sleep(0.5)
                puts "*   .   `    *  .      .     *           .              *               .      .        .       *          "
                sleep(1)
                puts "  *Cooper hurtles towards certain death in the grips of Gargantua's inescapable gravitational pull*  "
                puts " .   * .        .     .                 .       * ..          *   .                  .      *            "
                sleep(0.5)
                puts " *       .   *        . . *      ~    *  .        .          * .  `    .               . *         ` ~    "
                sleep(0.5)
                puts " `  .         *          `        .       .            *         .        ~        . `   .         ~       "
                sleep(2)
                puts "  You can try another star system name if you want."
                sleep(0.5)
                puts ""
                name = gets.chomp
            elsif tries == 2
                puts ""
                puts "Theres either something wrong with me or something wrong with you :("
                puts ""
                sleep(0.5)
                puts "Exiting"
                counter = 0
                until counter == 2
                    sleep(0.5)
                    puts "."
                    counter += 1
                end
                CLI.end

            else 
                tries += 1
                puts ""
                puts "That star doesn't appear to exist within #{Navigator.distance} parsecs. Please try another."
                puts ""
                name = gets.chomp
            end

        end

        if 0 < name.to_i && index_match >= name.to_i #checking if index number, then requesting from exoplanets
            Exoplanets.system(Api.names[name.to_i - 1])
        else
            Exoplanets.system(name)
        end
    end

    def self.end_of_line
        attempts = 0
        while attempts < 3
            attempts += 1 
            new_input = gets.chomp
            new_input == "restart" ? CLI.new.start : false
            new_input == "back" ? CLI.systems_within_distance(Exoplanets.names) : false
            new_input == "exit" ? CLI.end : false
            if new_input == "help"
                puts ""
                puts "You can type restart, back or exit."
                puts ""
                end_of_line
            elsif attempts == 3
                puts ""
                puts "Command not understood. Attempts exceeded. Restarting.."
                sleep(1)
                CLI.new.start
            else
                puts ""
                puts "Command not understood. Please try again."
                puts ""
            end
        end
    end
end
