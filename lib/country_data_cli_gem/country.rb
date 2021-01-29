class CountryDataCliGem::Country

    attr_accessor :name, :capital, :region, :population, :timezones, :borders, :currencies, :languages, :flag
    @@all = []

    def initialize(country)
        country.each do |k, v|
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
        print " "
        puts "Name: #{self.all[index].name}".underline
    end

    def self.capital(index)
        if self.all[index].capital.empty?
            print " Capital: "
            puts "This country does not have a specified capital.".colorize(:light_blue)
        else
            print " Capital: "
            puts "#{self.all[index].capital}".colorize(:light_blue)
        end
    end

    def self.region(index)
        if self.all[index].region.empty?
            print " Region: "
            puts "This country does not have a specified region.".colorize(:light_blue)
        else
            print " Region: "
            puts "#{self.all[index].region}".colorize(:light_blue)
        end
    end

    def self.population(index)
        population_conversion = self.all[index].population

        print " Population: "
        puts "#{population_conversion.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}".colorize(:light_blue)
    end

    def self.timezones(index)
        print " Timezone(s): "
        puts "#{self.all[index].timezones.join(", ")}".colorize(:light_blue)
    end

    def self.borders(index)
        if self.all[index].borders.empty?
            print " Border(s): "
            puts "This country has no borders. It is surrounded by water.".colorize(:light_blue)
        else
            print " Border(s): "
            puts "#{self.all[index].borders.join(", ")}".colorize(:light_blue)
        end
    end
    
    def self.currencies(index)
        currency_array = []
        self.all[index].currencies.each do |hash|
            currency_array << hash["name"] unless hash["name"] == nil
        end

        print " Currency/currencies: "
        puts "#{currency_array.join(", ")}".colorize(:light_blue)
    end

    def self.languages(index)
        language_array = []
        self.all[index].languages.each do |hash|
            language_array << hash["name"] unless hash["name"] == nil
        end

        print " Language(s): "
        puts "#{language_array.join(", ")}".colorize(:light_blue)
    end

    def self.flag(index)
        flag = self.all[index].flag

        print " Flag: "
        puts "#{flag}".colorize(:light_blue)

        sleep 3

        if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
            system "start #{flag}"
        elsif RbConfig::CONFIG['host_os'] =~ /darwin/
            system "open #{flag}"
        elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
            system "xdg-open #{flag}"
        else
            puts ""
        end
    end

    def self.total_countries
        puts " There are a total of #{self.all.count} countries around the world."
        puts ""
    end

    def self.total_capitals
        total_capitals = self.all.select {|country| country.capital.empty?}

        puts " There are #{total_capitals.count} countries in the world that have no capital."
        puts " They are:"
        total_capitals_sorted = total_capitals.sort {|country1, country2| country1.name <=> country2.name}
        total_capitals_sorted.each.with_index(1) do |country, index|
            puts " #{index}. #{country.name}"
        end
        puts ""
    end

    def self.total_population
        total_population_count = self.all.sum {|country| country.population.to_i}
        puts " The total population of the entire world is #{total_population_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}!"
        puts ""
    end

    def self.sorted_by_population
        self.all.sort {|country1, country2| country1.population.to_i <=> country2.population.to_i}
    end

    def self.least_populated_country
        puts " The ten least populated countries in the world are:"

        sorted_by_population[0..9].each.with_index(1) do |country, index|
            puts " #{index}. #{country.name}, Population: #{country.population.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}"
        end
        puts ""
    end

    def self.most_populated_country
        puts " The ten most populated countries in the world are:"

        sorted_by_population[-10..CountryDataCliGem::Country.all.size].each.with_index(1) do |country, index|
            puts " #{index}. #{country.name}, Population: #{country.population.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}"
        end

        puts " #{sorted_by_population.last.name} is the country with the highest population in the entire world!"
        puts ""
    end

    def self.total_timezones
        most_timezones = self.all.sort {|country1, country2| country1.timezones.size <=> country2.timezones.size}

        puts " The country that has the most time zones is #{most_timezones.last.name}."
        puts " #{most_timezones.last.name} has a total of #{most_timezones.last.timezones.count} different timezones."
        puts ""    
    end

    def self.total_borders
        most_borders = self.all.sort {|country1, country2| country1.borders.size <=> country2.borders.size}
        
        puts " The country that has the most borders is #{most_borders.last.name}."
        puts " #{most_borders.last.name} has a total of #{most_borders.last.borders.count} borders."
        puts ""
    end

    def self.total_currencies
        most_currencies_sorted = self.all.sort {|country1, country2| country1.currencies.size <=> country2.currencies.size}
        total_currencies_array = []
        most_currencies_sorted.last.currencies.each do |hash|
            total_currencies_array << hash["name"] unless hash["name"] == nil
        end
        puts " The country that has the most currencies is #{most_currencies_sorted.last.name}."
        puts " #{most_currencies_sorted.last.name} has a total of #{total_currencies_array.count} different currencies."
        puts " They are:"
        sorted_array = total_currencies_array.sort
        sorted_array.each.with_index(1) do |currency, index| 
            puts " #{index}. #{currency}"
        end
        puts ""
    end

    def self.total_languages
        most_languages_sorted = self.all.sort {|country1, country2| country1.languages.size <=> country2.languages.size}
        total_languages_array = []
        most_languages_sorted.last.languages.each do |hash|
            total_languages_array << hash["name"] unless hash["name"] == nil
        end
        puts " The country that speaks the most languages is #{most_languages_sorted.last.name}."
        puts " #{most_languages_sorted.last.name} speaks #{total_languages_array.count} different languages."
        puts " They are:"
        sorted_array = total_languages_array.sort
        sorted_array.each.with_index(1) do |language, index| 
            puts " #{index}. #{language}"
        end
        puts ""
    end

end