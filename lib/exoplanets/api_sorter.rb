require 'smarter_csv'
class Api_Sorter
    @@stars = { #contains properly sorted data for easy access via Api_Sorter.all
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
        @@stars
    end

    def self.clear
        @@stars = {}
    end

    def self.sort(response) #rearranges hash so that exoplanets exist under star systems. removes duplicate star systems and refines list for display. 
        response.each do |planet|
            # puts planet
                planet.each do |key, stat|
                    stat.nil? ? planet[key] = "--" : false
                    # puts key,stat
                end
            star_data = {
                    mass: planet["st_mass"],
                    size: planet["st_rad"],
                    temp: planet["st_teff"],
                    dist: planet["sy_dist"],
                    exoplanets: planet["sy_pnum"]
                }
            # puts star_data
            host = planet["hostname"]

            if @@stars.key?(host)
                #send corresponding planet into an array of planets within the star in @@stars
                @@stars[host]["planet_names"] << planet["pl_name"]
            else
                @@stars[host] = star_data
                @@stars[host]["planet_names"] = [planet["pl_name"]]
            end
        end
        # puts @@stars
           
            
                
        # end
        @@stars
    end
end

    


   
