class Player
    attr_reader :name, :game

    def initialize(name, symbol, game)
        @name 	= name
        @symbol = symbol
        @game 	= game
    end

    def plays(reason = :current_turn)
        # A player plays:
        # - when it is his turn,
        # - when he entered a wrong column number before and
        # - when he chose an occupied square before
        if reason == :no_square_left
            puts "-- #{@name.capitalize} --\n There is no place left in that column!\nP lease try again :)\n"
        else
            puts "-- #{@name.capitalize} --\n Where do you want to put your piece?\n (Please enter the number of the column)\n"
        end

        begin
            selects_action
        rescue StandardError => error
            puts error
            retry
        end
    end

    def selects_action
        # Raise an exception if the text doesn't match:
        # - with the 'quit' command or
        # - with a column number
        text = gets.chomp
        if !text.match(/^([1-7+]|quit)$/)
            raise StandardError, "-- #{@name.capitalize} --\n You didn't enter a column number!\n Please try again :)\n"
        end

        # A player can:
        # - choose a square
        # - quit the game
        if text.match(/^[1-7+]$/)
            if @game.board.squares[@game.board.lines-1][text.to_i-1].state.class == Symbol
                plays(:no_square_left)
                return
            end

            @game.board.squares.each do |line|
                if line[text.to_i-1].state.nil?
                    chose_square = line[text.to_i-1]
                    chose_square.state = @symbol
                    break
                end
            end
            @game.next_player(self)
        elsif text == 'quit'
            gives_up
        end
    end

    def gives_up
        @game.finish?(true)
    end
end
