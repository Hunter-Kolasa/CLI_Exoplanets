class Navigator
    def self.user_start(input)
        #use flow chart for if statements. try to keep efficient
        size = Api.get_size(input)
        if input.to_i < 10
            Api.get_data(input)
        else
            puts ""
            puts "This will return #{size} instances of data. Are you sure you want to continue? [Y/N}"
            continue = gets.chomp.upcase
            until continue == "Y" || "N" do
                put ""
                puts "Please enter Y or N."
            end
            if continue == "Y"
                Api.get_data(input)
            else
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
    def self.system(name)
        tries = 0
        index_match = Exoplanets.names.size
        until Exoplanets.names.include?(name) || 0 < name.to_i && index_match >= name.to_i  || tries == 2
            name == "exit" ? CLI.end : false
            name == "restart" ? CLI.new.start : false
            if name == "gargantua"
                puts "See you on the other side slick!!"
                sleep(2)
                puts "-Cooper hurtles towards certain death in the grips of Gargantua's inescapable gravitational pull-"
                puts ""
                sleep(1)
                puts "You can try another star system name if you want."
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
            sleep(0.5)
            puts "Exiting"
            sleep(0.5)
            puts "."
            sleep(0.5)
            puts "."
            sleep(0.5)
            CLI.end
        elsif 0 < name.to_i && index_match >= name.to_i
            Exoplanets.system(Exoplanets.names[name.to_i - 1])
        else
            Exoplanets.system(name)
        end
    end
end
