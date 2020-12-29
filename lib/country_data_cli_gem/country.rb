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
        puts "Name: #{self.all[index].name}"
    end

    def self.capital(index)
        if self.all[index].capital.empty?
            puts "Capital: This country does not have a specified capital."
        else
            puts "Capital: #{self.all[index].capital}"
        end
    end

    def self.region(index)
        if self.all[index].region.empty?
            puts "Region: This country does not have a specified region."
        else
            puts "Region: #{self.all[index].region}"
        end
    end

    def self.population(index)
        population = self.all[index].population
        puts "Population: #{population.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}"
    end

    def self.timezones(index)
        puts "Timezone(s): #{self.all[index].timezones.join(", ")}"
    end

    def self.borders(index)
        if self.all[index].borders.empty?
            puts "Border(s): This country has no borders and is surrounded by water. Therefore, it is an island."
        else
            puts "Border(s): #{self.all[index].borders.join(", ")}"
        end
    end
    
    def self.currencies(index)
        arr = []
        self.all[index].currencies.each do |hash|
            arr << hash["name"] unless hash["name"] == nil
        end
        puts "Currency/currencies: #{arr.join(", ")}"
    end

    def self.languages(index)
        arr = []
        self.all[index].languages.each do |hash|
            arr << hash["name"] unless hash["name"] == nil
        end
        puts "Language(s): #{arr.join(", ")}"
    end

    def self.flag(index)
        puts "Flag: #{self.all[index].flag}"
    end

    def self.country_data(index)
        name(index)
        capital(index)
        region(index)
        population(index)
        timezones(index)
        borders(index)
        currencies(index)
        languages(index)
        flag(index)
        puts "I hope you found that interesting! Would you like to learn more?"
    end

end