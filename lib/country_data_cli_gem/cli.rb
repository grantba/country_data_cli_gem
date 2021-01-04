class CountryDataCliGem::CLI

    def call      
        system("clear")
        welcome_logo                    
        puts ""
        puts ""
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "                       Would you like to learn data about various countries around the world?"                            
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts ""
        CountryDataCliGem::API.get_data
        sleep 3
        continue
    end

    def welcome_logo
        puts "               
                           ██     ██ ███████ ██       ██████  ██████  ███    ███ ███████                          
                           ██     ██ ██      ██      ██      ██    ██ ████  ████ ██                               
                           ██  █  ██ █████   ██      ██      ██    ██ ██ ████ ██ █████                            
                           ██ ███ ██ ██      ██      ██      ██    ██ ██  ██  ██ ██                               
                            ███ ███  ███████ ███████  ██████  ██████  ██      ██ ███████                          
                                                                                               
                                   ████████  ██████      ████████ ██   ██ ███████                                 
                                      ██    ██    ██        ██    ██   ██ ██                                      
                                      ██    ██    ██        ██    ███████ █████                                   
                                      ██    ██    ██        ██    ██   ██ ██                                      
                                      ██     ██████         ██    ██   ██ ███████                                 
                                                                                               
         ██████  ██████  ██    ██ ███    ██ ████████ ██████  ██    ██     ██████   █████  ████████  █████      
        ██      ██    ██ ██    ██ ████   ██    ██    ██   ██  ██  ██      ██   ██ ██   ██    ██    ██   ██     
        ██      ██    ██ ██    ██ ██ ██  ██    ██    ██████    ████       ██   ██ ███████    ██    ███████     
        ██      ██    ██ ██    ██ ██  ██ ██    ██    ██   ██    ██        ██   ██ ██   ██    ██    ██   ██     
         ██████  ██████   ██████  ██   ████    ██    ██   ██    ██        ██████  ██   ██    ██    ██   ██     
                                                                                                      
                                 ██████ ██      ██      ██████  ███████ ███    ███ ██                              
                                ██      ██      ██     ██       ██      ████  ████ ██                              
                                ██      ██      ██     ██   ███ █████   ██ ████ ██ ██                              
                                ██      ██      ██     ██    ██ ██      ██  ██  ██                                 
                                 ██████ ███████ ██      ██████  ███████ ██      ██ ██ ".colorize(:light_blue)                                                                                                                                            
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
        puts "Type '4' if you would like to learn interesting facts about all of the countries around the world."
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
        when "4"
            interesting_facts_all_countries
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
            print_country_data(index)
            continue
        else
            puts ""
            puts "That was an invalid response. Please select a number from the list."
            puts ""
            sleep 3
            ordered_list
        end
    end

    def random_selection
        index = rand(0..249)
        print_country_data(index)
        continue
    end

    def country_by_name
        puts ""
        puts "Please enter the name of the country you'd like to see more data about."
        puts ""
        country_selection = response
        if index = CountryDataCliGem::Country.all.find_index {|country| country.name.strip.downcase == country_selection}
            print_country_data(index)
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

    def print_country_data(index)
        puts ""
        CountryDataCliGem::Country.name(index)
        CountryDataCliGem::Country.capital(index)
        CountryDataCliGem::Country.region(index)
        CountryDataCliGem::Country.population(index)
        CountryDataCliGem::Country.timezones(index)
        CountryDataCliGem::Country.borders(index)
        CountryDataCliGem::Country.currencies(index)
        CountryDataCliGem::Country.languages(index)
        CountryDataCliGem::Country.flag(index)
        puts ""
        puts "I hope you found that interesting! Would you like to learn more?"
    end
    
    def interesting_facts_all_countries
        puts ""
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
        puts "                       Did you know?".colorize(:light_blue)
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
        puts ""
        CountryDataCliGem::Country.total_countries
        CountryDataCliGem::Country.total_country_capitals
        CountryDataCliGem::Country.total_population
        CountryDataCliGem::Country.least_populated_country
        CountryDataCliGem::Country.most_populated_country
        CountryDataCliGem::Country.total_country_timezones
        CountryDataCliGem::Country.total_borders
        CountryDataCliGem::Country.total_currencies
        CountryDataCliGem::Country.total_languages
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_blue)
        puts ""
        puts "I hope you found that interesting! Would you like to learn more?"
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