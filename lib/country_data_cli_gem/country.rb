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

    # def self.print_languages(index)
    #     self.all[index].languages.each do |hash|
    #         hash[:name]
    #     end
    #     binding.pry
    # end

    def self.population_conversion(index)
        population = self.all[index].population
        puts "Population: #{population.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}"
    end

    def self.borders(index)
        if self.all[index].borders.empty?
            puts "Border(s): This country has no borders and is surrounded by water. Therefore, it is an island."
        else
            puts "Border(s): #{self.all[index].borders.join(", ")}"
        end
    end

    def self.country_data(index)
        puts "Name: #{self.all[index].name}"
        puts "Capital: #{self.all[index].capital}"
        puts "Region: #{self.all[index].region}"
        population_conversion(index)
        puts "Timezone(s): #{self.all[index].timezones.join(", ")}"
        borders(index)
        #puts "Border(s): #{self.all[index].borders.join(", ")}" unless self.all[index].borders.empty?
        puts "Currency/Currencies: #{self.all[index].currencies[0]["name"]}"
        #puts "Language(s): "
        #print_languages(index)
        puts "Language(s): #{self.all[index].languages[0]["name"]}"
        puts "Flag: #{self.all[index].flag}"
        puts "I hope you found that interesting! Would you like to learn more?"
    end

end