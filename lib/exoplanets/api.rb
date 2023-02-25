require 'faraday'
class Api
    @@response = {}
    @@sorted_response = {}
    @@names = []

    def self.get_data(distance) #pulls all exoplanets within {distance} from NASA API
        puts 'in get_data'
        key = "yqVmBXutaEvqJrgIvwzzmI3T8Wcof0mWpbM6Nj7v"
        url = "https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+pl_name,pl_masse,sy_dist,st_radstr+from+ps
        +where+pl_masse+between+0.5+and+2.0&format=JSON"
        # @@test = HTTParty.get(url)
        @@response = Faraday.get(url)
        # puts @@response
        # binding.pry
        @@sorted_response = Api_Sorter.sort(@@response.body)
        Exoplanets.new(@@sorted_response)
        @@names = Exoplanets.names
    end

    def self.data_size #save number of exoplanes in current request
        @@response.size
    end

    def self.sorted_data #populate hash of sorted data, makes it so that api needs to only be sorted once
        @@sorted_response
    end
    
    def self.names #save array of star systems names
        @@names
    end

    def self.clear
        @@response = {}
        @@sorted_response = {}
        @@names = []
    end
end