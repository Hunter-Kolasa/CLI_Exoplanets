class Api
    @size = 0
    @response = {}
    def self.get_size(distance)
        key = "yqVmBXutaEvqJrgIvwzzmI3T8Wcof0mWpbM6Nj7v"
        url = "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?&table=exoplanets&select=pl_hostname,st_mass,st_rad,st_teff,st_dist,pl_pnum,pl_name&where=st_dist<#{distance}&order=st_dist&format=JSON"
        @response = JSON.parse(HTTParty.get(url))
        @size = @response.size
    end
    def self.get_data(distance)
        key = "yqVmBXutaEvqJrgIvwzzmI3T8Wcof0mWpbM6Nj7v"
        url = "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?&table=exoplanets&select=pl_hostname,st_mass,st_rad,st_teff,st_dist,pl_pnum,pl_name&where=st_dist<#{distance}&order=st_dist&format=JSON"
        @response = JSON.parse(HTTParty.get(url))
        Api_Sorter.sort(@response)
    end
end