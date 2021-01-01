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

    #Interesting facts: 
    #:name, :capital, :region, :population, :timezones, :borders, :currencies, :languages, :flag

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