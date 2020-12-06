class Exoplanets
    @@all = {}
    @@names = []

    def initialize(stars) #takes formatted hash, places into class variable @@all, pulls all star names(keys) and maps them to class variable @@names
        @@all = stars
        stars.keys.map do |name|
            @@names << name
        end

    end

    def self.all
        @@all
    end

    def self.clear
        @@all = {}
        @@names = []
    end

    def self.system(name) #takes name of star system and translates to name and data for star system. sends to CLI
        data = @@all[name]
        CLI.system(name, data)

    end
    
    def self.names
        @@names
    end
end