class CountryDataCliGem::CLI

    def call
        puts "Hi. Welcome to the Country Data CLI Gem!"
        puts "Would you like to learn data about various countries around the world?"
        CountryDataCliGem::API.get_data
        continue
    end

    def continue
        puts "Type 'y' for yes or 'exit' to leave the program."
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
        puts "Great! Please make a selection from the list below."
        puts "Type '1' if you would like to see a list of countries to choose from."
        puts "Type '2' if you would like a random country chosen for you."
        puts "Type '3' if you would like to type in the name of the country you would like more information about."

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
        selection = response
        if CountryDataCliGem::Country.all.find {|country| country.name.downcase.strip == selection}
            index = CountryDataCliGem::Country.all.find_index {|country| country.name.downcase.strip == selection}
            CountryDataCliGem::Country.country_data(index)
            continue
        else 
            @error_counter = 0 unless @error_counter == 1 || @error_counter == 2
            counter
        end
    end

    def counter
        @error_counter += 1
        case @error_counter
        when (1..2)
            invalid_response
        when (3)
            country_by_name_error_message
        end
    end

    def country_by_name_error_message
        puts "I'm sorry I'm having trouble understanding your response."
        puts "You may want to use (option 1) the list of countries to choose from as an alternative."
        puts "Would you like to continue?"
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