require_relative 'board'
require_relative 'player'

module TicTacToe
    class Game

        attr_reader :players, :board

        def initialize
            @board          = Board.new
            @players        = []
            @players_number = 2
            @symbols        = ['O', 'X']
        end

        def create
            # create the board
            @board.create

            #create players
            for i in 1..@players_number
                begin
                    player = create_player(i)
                    @players.push(player)
                rescue StandardError => error
                    print error
                    retry
                end
            end

            # Start message
            print "\n
---------------------------------------------------------\n
            **  Let's start the game  **"
        end

        def switch_player(current_player)
            display_board

            if finish?
                restart
            else
                current_index = @players.index(current_player)
                if current_index + 1 < @players.length
                    @current_player = @players[current_index + 1]
                else
                    @current_player = @players[0]
                end
                @current_player.plays
            end
        end

        def start
            create
            display_board
            @current_player = @players[0]
            @current_player.plays
        end

        def finish?(by_abandon = false)
            if by_abandon
                print "#{@current_player.name.capitalize} gives up!\n"
                true
            elsif @board.has_winning_line?
                print "\n
*********************    :)      *********************\r
                #{@current_player.name.capitalize} wins! CONGRATS!\r
*********************    :)      *********************\n"
                true
            elsif @board.is_full?
                print "\n
*********************    :(      *********************\r
                No one wins. The board is full!\r
*********************    :(      *********************\n"
                true
            else
                false
            end
        end


        private
        def create_player(index)
            print "Player #{index} name?"

            # Raise exception if the name is empty
            name = gets.chomp
            if name.empty?
                raise StandardError, "You must provide a name.\n"
            end

            # Create a player instance
            Player.new(name, @symbols[index - 1], self)
        end

        def display_board
            print "\n
---------------------------------------------------------\n"
            print "You can quit the game typing 'quit' as a command.\n\n"
            @board.display
            print "\n\n"
        end

        def restart
            print "\n
---------------------------------------------------------\n
                **  The game is over  **\n
---------------------------------------------------------\n"

            begin
                print  "\n Play another party ? (y/n)"
                response = gets.chomp
                raise StandardError, "You didn't answer the question. Please enter 'y' for yes and 'n' for no." if !response.match(/^[y|n]$/)

                case response
                    when 'y'
                        new_game = Game.new
                        new_game.start
                    when 'n'
                        print "\nByebye! See you next time!\n"
                        exit
                end
            rescue StandardError => error
                print error
                retry
            rescue SystemExit
            end
        end

    end
end
