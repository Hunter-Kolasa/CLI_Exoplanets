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
        response.each do |p|
            p.each do |key, stat|
                stat.nil? ? p[key] = "--" : false
            end
            star_data = {
                mass: p["st_mass"],
                size: p["st_rad"],
                temp: p["st_teff"],
                dist: p["sy_dist"],
                exoplanets: p["sy_pnum"]
            }
            host = p["hostname"]
            if @@stars.key?(host)
                #send corresponding planet into an array of planets within the star in @@stars
                if !@@stars[host]["planet_names"].include? p["pl_name"]
                    @@stars[host]["planet_names"] << p["pl_name"]
                end
            else
                @@stars[host] = star_data
                @@stars[host]["planet_names"] = p["pl_name"]
            end
        end   
        @@stars
    end
end

    


   
