class CLI

    def call
        puts "Hi. Welcome to the Country Data CLI Gem."
        puts "Would you like to learn data about various countries around the world?"
        API.get_data
        continue
    end

    def continue
        puts "Please type 'y' for yes or 'exit' to leave the program."
        menu
    end

    def response
        gets.strip
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
            selection_by_name
        when "exit"
            exit_message
        else
            invalid_response
        end
    end

    def ordered_list
        Country.all.each.with_index(1) do |country, index|
            puts "#{index}. #{country.name}"
        end
        option_from_ordered_list
    end

    def random_selection
        index = rand(0..249)
        country_data(index)
        continue
    end

    def option_from_ordered_list
        index = response.to_i - 1
        country_data(index)
        continue
    end

    def country_data(index)
        puts "Name: #{Country.all[index].name}"
        puts "Capital: #{Country.all[index].capital}"
        puts "Region: #{Country.all[index].region}"
        puts "Population: #{Country.all[index].population}"
        puts "Timezone(s): #{Country.all[index].timezones.join(", ")}"
        puts "Border(s): #{Country.all[index].borders.join(", ")}"
        puts "Currency/Currencies: #{Country.all[index].currencies[0]["name"]}"
        puts "Language(s): #{Country.all[index].languages[0]["name"]}"
        puts "Flag: #{Country.all[index].flag}"
        puts "I hope you found that interesting! Would you like to learn more?"
    end

    def invalid_response
        puts "I'm sorry, I didn't quite understand your response."
        continue
    end

    def exit_message
        puts "Thanks for checking out the Country Data CLI Gem. Have a great day. Good-bye!"
    end

end