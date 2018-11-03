require 'colorize'

module Webcolors
    class Output

        def self.puts_error(message)
            puts message.red
            abort
        end

        def self.puts_notif(message)
            puts message.green
        end

        def self.puts_question(message)
            puts message.light_red
        end

    end
end
