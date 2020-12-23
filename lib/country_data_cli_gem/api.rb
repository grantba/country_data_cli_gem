class API

    def self.get_data
        response = RestClient.get("https://restcountries.eu/rest/v2/all")
        country_array = JSON.parse(response)
        country_array.each do |country|
            Country.new(country)
        end
    end

end