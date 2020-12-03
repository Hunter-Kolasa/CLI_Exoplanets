class Api
    @response = {}
    def self.get_data(distance) #pulls all exoplanets within {distance} from NASA API
        key = "yqVmBXutaEvqJrgIvwzzmI3T8Wcof0mWpbM6Nj7v"
        url = "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?&table=exoplanets&select=pl_hostname,st_mass,st_rad,st_teff,st_dist,pl_pnum,pl_name&where=st_dist<#{distance}&order=st_dist&format=JSON"
        @response = JSON.parse(HTTParty.get(url))
    end
    def self.data_size
        @response.size
    end
    def self.sorted_data #takes lsit and sends off to be sorted
        Api_Sorter.sort(@response)
    end

end