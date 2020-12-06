class Api
    @@response = {}
    @@sorted_response = {}
    @@names = []

    def self.get_data(distance) #pulls all exoplanets within {distance} from NASA API
        key = "yqVmBXutaEvqJrgIvwzzmI3T8Wcof0mWpbM6Nj7v"
        url = "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?&table=exoplanets&select=pl_hostname,st_mass,st_rad,st_teff,st_dist,pl_pnum,pl_name&where=st_dist<#{distance}&order=st_dist&format=JSON"
        @@response = JSON.parse(HTTParty.get(url))
        @@sorted_response = Api_Sorter.sort(@@response) 
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
end