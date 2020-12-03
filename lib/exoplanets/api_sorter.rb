class Api_Sorter
    @stars = { #contains properly sorted data for easy access via Api_Sorter.all
        # "Proxima Cen": 
        #     {Mass: "m",
        #     Size: "r",
        #     Temp: "k",
        #     Dist: "p",
        #     num_exoplanets: "n",
        #     names: ["planet1", "planet2", "planet3.."]},
        # "GJ 411":
        #     {Mass: "m",
        #     Size: "r",
        #     Temp: "k",
        #     Dist: "p",
        #     num_exoplanets: "n",
        #     names: ["planet1", "planet2", "planet3.."]}
        }
    def self.all
        @stars
    end
    def self.clear
        @stars = {}
    end
    def self.sort(response) #rearranges hash so that exoplanets exist under star systems. removes duplicate star systems and refines list for display. 
        response.each do |planet|
            star_data = {
                mass: planet["st_mass"],
                size: planet["st_rad"],
                temp: planet["st_teff"],
                dist: planet["st_dist"],
                exoplanets: planet["pl_pnum"]
            }
            
            if @stars.key?(planet["pl_hostname"])

                #send corresponding planet into an array of planets within the star in @stars
                @stars[planet["pl_hostname"]]["planet_names"] << planet["pl_name"]

            else
                @stars[planet["pl_hostname"]] = star_data
                
                @stars[planet["pl_hostname"]]["planet_names"] = [planet["pl_name"]]
            end
        end
        Exoplanets.new(@stars) #starts new Exoplanets instance using @stars
    end
end

    


   
