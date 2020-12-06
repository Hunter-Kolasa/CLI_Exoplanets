class Navigator
    def self.user_start(distance) #recieves distance input from CLI
        counter = 0
        # @@distance == "exit" ? CLI.end : false
        # @@distance == "restart" ? start.new : false #<--move from CLI.start
        while distance.to_i == 0 
            if counter == 2
                puts "Invalid input. Attempts exceeded. It was a pleasure almost serving you."
                CLI.end
            else
                puts "Invalid input. Please try again."
                counter += 1
                distance = gets.chomp
            end
        end
            
        Api.get_data(distance) #pulls custom data from API, stores in Api instance variable
        @@size = Api.data_size 
        if distance.to_i < 10 #checks if data return will be very large. Either calls Api or double checks with user with size of set to be returned
            Api.sorted_data
        else 
            puts ""
            puts "This will return #{size} instances of exoplanets. Are you sure you want to continue? [Y/N}"
            continue = gets.chomp.upcase
            until continue == "Y" || continue == "N" do
                puts ""
                puts "Please enter Y or N."
            end

            if continue == "Y" #call Api class to return data from API
                Api.sorted_data
            else #restart w/ fancy counter for aesthetics
                puts ""
                puts "Ok, I'll send you back to the main screen to select a new distance."
                counter = 0
                until counter == 3
                    sleep(0.25)
                    puts "."
                    sleep(0.25)
                    counter += 1
                end
                CLI.new.start
            end
        end
    end
    def self.size #used by CLI to display number of exoplanets being returned
        @@size
    end
    def self.system(name) #checks name or index number for validity in current list. cool Interstellar easter egg. if wrong input x3 -> exit. else sends system name to Exoplanets
        tries = 0
        index_match = Exoplanets.names.size
        until Exoplanets.names.include?(name) || 0 < name.to_i && index_match >= name.to_i  || tries == 2
            name == "exit" ? CLI.end : false
            name == "restart" || name == "back" ? CLI.new.start : false
            
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
            else
                tries += 1
                puts "That star doesn't appear to exist within #{CLI.distance} parsecs. Please try another."
                name = gets.chomp
            end
        end

        if tries == 2
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
        elsif 0 < name.to_i && index_match >= name.to_i
            Exoplanets.system(Exoplanets.names[name.to_i - 1])
        else
            Exoplanets.system(name)
        end
    end
end
