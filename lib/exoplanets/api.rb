class Api
    @@response = {}
    @@sorted_response = {}
    @@names = []

    def self.get_data(distance) #pulls all exoplanets within {distance} from NASA API
        key = "yqVmBXutaEvqJrgIvwzzmI3T8Wcof0mWpbM6Nj7v"
        url = "https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+hostname,st_mass,st_rad,st_teff,sy_dist,sy_pnum,pl_name+from+ps+where+sy_dist+<+#{distance}+&format=JSON"
        @@response = HTTParty.get(url)
        @@sorted_response = Api_Sorter.sort(@@response) 
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