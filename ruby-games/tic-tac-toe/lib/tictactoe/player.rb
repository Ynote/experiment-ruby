module TicTacToe
    class Player

        attr_reader :name, :game, :symbol

        def initialize(name, symbol, game)
            @name    = name
            @game    = game
            @symbol  = symbol
            @mapping = {'a'   => 0, 'b' => 1, 'c' => 2}
        end

        def plays(reason = :current_turn)
            if reason == :previous_already_occupy
                print "-- #{@name.capitalize} --\n This square is already occupied. Please choose another one.\n (Enter the square coordinates. Eg: 1:a)\n"
            else
                print "-- #{@name.capitalize} --\n Which square do you choose?\n (Enter the square coordinates. Eg: 1:a)\n"
            end

            begin
                selects_action
            rescue StandardError => error
                print error
                retry
            end
        end

        def selects_action
            action = gets.chomp

            if !action.match(/^([1-3]:[a-c]|quit)$/)
                raise StandardError, "-- #{@name.capitalize} --\n This command doesn't exist. Please try again :)\n"
            end

            case action
                when 'quit'
                gives_up
                else
                    coordinates   = action.split(':')
                    row           = coordinates[0].to_f - 1
                    column        = @mapping[coordinates[1]]
                    chosen_square = @game.board.grid[row][column]

                    if chosen_square.owner.nil?
                        chosen_square.owner = self
                    else
                        plays(:previous_already_occupy)
                        return
                    end

                    @game.switch_player(self)
            end
        end

        def gives_up
            @game.finish?(true)
        end
    end
end
