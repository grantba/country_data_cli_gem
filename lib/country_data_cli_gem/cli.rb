class CountryDataCliGem::CLI

    def call
        puts "Hi. Welcome to the Country Data CLI Gem."
        puts "Would you like to learn data about various countries around the world?"
        CountryDataCliGem::API.get_data
        continue
    end

    def continue
        puts "Please type 'y' for yes or 'exit' to leave the program."
        menu
    end

    def response
        gets.strip.downcase
    end

    def menu
        selection = response

        if selection == "y"
            user_options
        elsif selection == "exit"
            exit_message
        else
            invalid_response
        end
    end

    def user_options
        puts "Great! Please choose which country you would like more information about."
        puts "Please type '1' if you would like to see a list of countries to choose from."
        puts "Please type '2' if you would like a random country chosen for you."
        puts "Please type '3' if you would like to type in the name of the country you would like more information about."

        selection = response

        case selection
        when "1"
            ordered_list
        when "2"
            random_selection
        when "3"
            country_by_name
        when "exit"
            exit_message
        else
            invalid_response
        end
    end

    def ordered_list
        CountryDataCliGem::Country.all.each.with_index(1) do |country, index|
            puts "#{index}. #{country.name}"
        end
        puts "Please type the number of the country you'd like to see more data about."
        option_from_ordered_list
    end

    def random_selection
        index = rand(0..249)
        CountryDataCliGem::Country.country_data(index)
        continue
    end

    def country_by_name
        puts "Great. Please enter the name of the country you'd like to see more data about."
        selection = response.capitalize().strip
        index = CountryDataCliGem::Country.all.find_index {|country| country.name == selection}
        CountryDataCliGem::Country.country_data(index)
        continue
    end

    def option_from_ordered_list
        index = response.to_i - 1
        CountryDataCliGem::Country.country_data(index)
        continue
    end

    def invalid_response
        puts "I'm sorry, I didn't quite understand your response."
        continue
    end

    def exit_message
        puts "Thanks for checking out the Country Data CLI Gem. Have a great day. Good-bye!"
    end

end