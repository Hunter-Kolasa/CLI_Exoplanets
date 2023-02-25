require 'faraday'
class Api
    @@response = {}
    @@sorted_response = {}
    @@names = []

    def self.get_data(distance) #pulls all exoplanets within {distance} from NASA API
        # puts 'in get_data'
        # key = "yqVmBXutaEvqJrgIvwzzmI3T8Wcof0mWpbM6Nj7v"
        url = "https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+pl_name,st_teff,pl_masse,sy_pnum,sy_dist,pl_rade,hostname+from+ps
        +where+sy_dist<=#{distance}&format=JSON"
        # @@test = HTTParty.get(url)
        @@raw_response = Faraday.get(url)
        @@response = JSON.parse(@@raw_response.body).uniq{|pl| [pl['pl_name']]}
        JSON.parse(@@raw_response.body).group_by{|pl| pl['pl_name']}.map do |_,collection|
            count = 1
            collection.reduce do |result, item|
                puts result
                # if item['st_teff'] != nil
                #     # if result['st_teff'] = nil 
                #         result['st_teff'] = 0
                #     count += 1
                #     # puts result
                #     result['st_teff'] += item['st_teff']
                #     end
                # end
                # result['st_teff'] = result['st_teff']/count
                # puts result
            end
        end
        # puts @@response
        # binding.pry
        @@sorted_response = Api_Sorter.sort(@@response)
        Exoplanets.new(@@sorted_response)
        @@names = Exoplanets.names
    end

    def self.data_size #save number of exoplanets in current request
        @@response.length
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