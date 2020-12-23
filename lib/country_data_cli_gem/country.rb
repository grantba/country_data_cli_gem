class Country

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

    def self.country_data(index)
        puts "Name: #{self.all[index].name}"
        puts "Capital: #{self.all[index].capital}"
        puts "Region: #{self.all[index].region}"
        puts "Population: #{self.all[index].population}"
        puts "Timezone(s): #{self.all[index].timezones.join(", ")}"
        puts "Border(s): #{self.all[index].borders.join(", ")}"
        puts "Currency/Currencies: #{self.all[index].currencies[0]["name"]}"
        puts "Language(s): #{self.all[index].languages[0]["name"]}"
        puts "Flag: #{self.all[index].flag}"
        puts "I hope you found that interesting! Would you like to learn more?"
    end

end