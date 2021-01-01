class CountryDataCliGem::Country

    attr_accessor :name, :capital, :region, :population, :timezones, :borders, :currencies, :languages, :flag
    @@all = []

    def initialize(country_hash)
        country_hash.each do |k, v|
            self.send("#{k}=", v) if self.respond_to?("#{k}=")
        end
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.name(index)
        puts "Name: #{self.all[index].name}".underline
    end

    def self.capital(index)
        if self.all[index].capital.empty?
            print "Capital: "
            puts "This country does not have a specified capital.".colorize(:light_blue)
        else
            print "Capital: "
            puts "#{self.all[index].capital}".colorize(:light_blue)
        end
    end

    def self.region(index)
        if self.all[index].region.empty?
            print "Region: "
            puts "This country does not have a specified region.".colorize(:light_blue)
        else
            print "Region: "
            puts "#{self.all[index].region}".colorize(:light_blue)
        end
    end

    def self.population(index)
        population_conversion = self.all[index].population
        print "Population: "
        puts "#{population_conversion.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}".colorize(:light_blue)
    end

    def self.timezones(index)
        print "Timezone(s): "
        puts "#{self.all[index].timezones.join(", ")}".colorize(:light_blue)
    end

    def self.borders(index)
        if self.all[index].borders.empty?
            print "Border(s): "
            puts "This country has no borders and is surrounded by water. Therefore, it is an island.".colorize(:light_blue)
        else
            print "Border(s): "
            puts "#{self.all[index].borders.join(", ")}".colorize(:light_blue)
        end
    end
    
    def self.currencies(index)
        arr = []
        self.all[index].currencies.each do |hash|
            arr << hash["name"] unless hash["name"] == nil
        end
        print "Currency/currencies: "
        puts "#{arr.join(", ")}".colorize(:light_blue)
    end

    def self.languages(index)
        arr = []
        self.all[index].languages.each do |hash|
            arr << hash["name"] unless hash["name"] == nil
        end
        print "Language(s): "
        puts "#{arr.join(", ")}".colorize(:light_blue)
    end

    def self.flag(index)
        print "Flag: " 
        puts "#{self.all[index].flag}".colorize(:light_blue)
    end

    def self.total_countries
        puts "There are a total of #{self.all.count} countries around the world."
        puts ""
    end

    def self.total_country_capitals
        total_capitals = self.all.select {|country| country.capital.empty?}
        puts "There are #{total_capitals.count} countries in the world that have no capital."
        puts "They are:"
        total_capitals.each.with_index(1) do |country, index|
            puts "#{index}. #{country.name}"
        end
        puts ""
    end
    
    def self.total_country_regions
        total_regions = self.all.select.uniq {|total_regions| total_regions.region} 
        total_regions_count = total_regions.select {|country| country.region unless country.region.empty?}
        puts "There are a total of #{total_regions_count.count} different regions around the world."
        puts "They are:"
        total_regions.each.with_index(1) do |country, index|
            puts "#{index}. #{country.region}" unless country.region.empty?
        end
        puts ""
    end

    def self.total_population
        total_population_count = self.all.sum {|country| country.population.to_i}
        puts "The total population of the entire world is #{total_population_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}!"
        puts ""
    end

    def self.least_populated_country
        least_populated = self.all.sort {|country1, country2| country1.population.to_i <=> country2.population.to_i}
        puts "The ten least populated countries in the world are:"
        least_populated[0..9].each.with_index(1) do |country, index|
            puts "#{index}. #{country.name}, Population: #{country.population.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}"
        end
        puts ""
    end

    def self.most_populated_country
        most_populated = self.all.sort {|country1, country2| country1.population.to_i <=> country2.population.to_i}
        puts "The ten most populated countries in the world are:"
        most_populated[-10..CountryDataCliGem::Country.all.size].each.with_index(1) do |country, index|
            puts "#{index}. #{country.name}, Population: #{country.population.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}"
        end
        puts "#{most_populated.last.name} is the country with the highest population in the entire world!"
        puts ""
    end

    def self.total_country_timezones
        total_timezones = []
        self.all.each do |country|
            total_timezones << country.timezones if country.timezones.size == 1
        end
        self.all.each do |countries|
            if countries.timezones.size > 1
                    countries.each do |country|
                    total_timezones << country.timezones
                end 
            else
                break
            end
        end
        total_timezones_count = total_timezones.flatten.uniq.sort
        puts "There are a total of #{total_timezones_count.count} different timezones around the world."
        puts "They are:"
        total_timezones_count.each.with_index(1) do |timezone, index|
            puts "#{index}. #{timezone}" unless timezone.empty?
        end
        puts ""    
    end
    #Interesting facts: 
    #:borders, :currencies, :languages, :flag

    def self.interesting_facts
        puts ""
        puts "~~~~~~~~~~~~~"
        puts "Did you know?"
        puts "~~~~~~~~~~~~~"
        puts ""
        total_countries
        total_country_capitals
        total_country_regions
        total_population
        least_populated_country
        most_populated_country
        total_country_timezones
        puts "I hope you found that interesting! Would you like to learn more?"
    end

    def self.country_data(index)
        puts ""
        name(index)
        capital(index)
        population(index)
        timezones(index)
        borders(index)
        currencies(index)
        languages(index)
        flag(index)
        puts ""
        puts "I hope you found that interesting! Would you like to learn more?"
    end

end