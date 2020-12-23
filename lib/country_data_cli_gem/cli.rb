class CLI

    def call
        puts "Hi. Welcome to the Country Data CLI Gem."
        puts "Would you like to learn data about various countries around the world?"
        continue
    end

    def continue
        puts "Please type 'y' to continue or 'exit' to leave the program."
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

    end

    def invalid_response
        puts "I'm sorry, I didn't quite understand your response."
        continue
    end

    def exit_message
        puts "Thanks for checking out the Country Data CLI Gem. Have a great day. Good-bye!"
    end

end