class Country

    attr_accessor :name, :currency, :language, :capital_city
    @@all = []

    def initialize(name, currency, language, capital_city)
        @name = name
        @currency = currency
        @language = language
        @capital_city = capital_city
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

end