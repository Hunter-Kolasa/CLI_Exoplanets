class Exoplanets
    @@all = {}
    @@names = []

    def initialize(stars)
        @@all = stars
        stars.keys.map do |name|
            @@names << name
        end

        CLI.systems_within_distance(@@names)
    end

    def self.all
        @@all
    end
    def self.clear
        @@all = {}
        @@names = []
    end
    def self.system(name)
        data = @@all[name]
        CLI.system(name, data)

    end
    def self.names
        @@names
    end
end