class CountryDataCliGem::CLI

    def call      
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "Hi. Welcome to the Country Data CLI Gem!"
        puts "Would you like to learn data about various countries around the world?"
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts ""
        CountryDataCliGem::API.get_data
        continue
    end

    def continue
        puts "Type 'y' to continue or 'exit' to leave the program."
        puts ""
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
        puts ""
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "Great! Please make a selection from the list below."
        puts ""
        puts "Type '1' if you would like to see a list of countries to choose from."
        puts "Type '2' if you would like a random country chosen for you."
        puts "Type '3' if you would like to type in the name of the country you would like more information about."
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts ""

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
        puts ""
        CountryDataCliGem::Country.all.each.with_index(1) do |country, index|
            puts "#{index}. #{country.name}"
        end
        puts ""
        puts "Type the number of the country you'd like to see more data about."
        puts ""
        option_from_ordered_list
    end

    def option_from_ordered_list
        index = response.to_i - 1
        if index >= 0 && index <= CountryDataCliGem::Country.all.length - 1
            CountryDataCliGem::Country.country_data(index)
            continue
        else
            puts ""
            puts "That was an invalid response. Please select a number from the list."
            puts ""
            sleep 5
            ordered_list
        end
    end

    def random_selection
        index = rand(0..249)
        CountryDataCliGem::Country.country_data(index)
        continue
    end

    def country_by_name
        puts ""
        puts "Please enter the name of the country you'd like to see more data about."
        puts ""
        country_selection = response
        if index = CountryDataCliGem::Country.all.find_index {|country| country.name.strip.downcase == country_selection}
            CountryDataCliGem::Country.country_data(index)
            continue
        else 
            @error_counter = 0 unless @error_counter == 1 || @error_counter == 2
            error_counter
        end
    end

    def error_counter
        @error_counter += 1
        case @error_counter
        when (1..2)
            invalid_response
        when (3)
            country_by_name_error_message
        end
    end

    def country_by_name_error_message
        puts ""
        puts "I'm sorry I'm having trouble understanding your response!"
        puts "You may want to select option 1 to see the list of countries to choose from as an alternative."
        puts ""
        continue
    end

    def invalid_response
        puts ""
        puts "I'm sorry, I didn't quite understand your response."
        continue
    end

    def exit_message
        puts ""
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "Thanks for checking out the Country Data CLI Gem. Have a great day. Good-bye!"
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    end

end