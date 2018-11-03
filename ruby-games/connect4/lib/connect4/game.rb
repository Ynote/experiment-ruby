require_relative 'board'
require_relative 'player'

class Game

    attr_reader :player_1, :player_2, :start_time, :board

    def initialize
        @current_player
    end

    private
    def create
        # Create the game board
        @board = Board.new
        @board.create

        # Create 2 players
        begin
            @player_1 = create_player(:player_1)
        rescue StandardError => error
            print error
            retry
        end

        begin
            @player_2 = create_player(:player_2)
        rescue StandardError => error
            print error
            retry
        end

        # Start message
        puts "\n--------------------------------------------\n          ** Let's start the game ! **\n--------------------------------------------\n          #{@player_1.name.capitalize} <= vs => #{@player_2.name.capitalize}\n--------------------------------------------\n"
        gets
        @start_time = Time.now
    end

    def create_player(symbol)
        # Display question
        if symbol == :player_1
            puts "First player's name ? "
        elsif symbol == :player_2
            puts "Second player's name ? "
        end

        # Raise an exception if the name is empty
        name = gets.chomp
        if name.empty?
            raise StandardError, "You must provide a name.\n"
        end

        # Create a player instance
            Player.new(name, symbol, self)
    end

    def player_turn(player)
        if finish?
            restart
        else
            @current_player = player
            player.plays
        end
    end

    public
    def start
        create
        display_game_board
        player_turn(@player_1)
    end

    def restart
        puts "\n--------------------------------------------\n          **  The game is over  **\n--------------------------------------------\n"

        begin
            puts "\n Play another party ? (y/n)"
            text = gets.chomp
            raise StandardError, "You didn't answer the question. Please enter 'y' for yes and 'n' for no." if !text.match(/^[y|n]$/)
            if text == 'y'
                jeu_2 = Game.new
                jeu_2.start
            elsif text == 'n'
                puts "\nByebye! See you next time!\n"
                return
            end
        rescue StandardError => error
            print error
            retry
        end
    end

    def finish?(by_abandon = false)
        # A game can be finish:
        # - when a player gives up,
        # - when the board is full or
        # - when a player wins
        if by_abandon == true
            puts " => #{@current_player.name.capitalize} gives up!"
            return true
        elsif @board.is_full?
            puts " => No one wins. The board is full."
            return true
        elsif @board.has_required_vertical_identical_squares? || @board.has_required_horizontal_identical_squares? || @board.has_required_rtl_diagonal_identical_squares? || @board.has_required_ltr_diagonal_identical_squares?
            puts " => #{@current_player.name.capitalize} wins!"
            return true
        end
        false
    end

    def next_player(current_player)
        display_game_board
        current_player == @player_1 ? player_turn(@player_2) : player_turn(@player_1)
    end

    def display_game_board
        # Display the game duration
        now = Time.now
        duration = now - @start_time
        hours, minutes, seconds = (duration/60/60%60).to_i, (duration/60%60).to_i, (duration%60).to_i
        puts "\n--------------------------------------------"
        puts "\n\n Game duration: #{hours}h#{minutes}min#{seconds}sec\n"

        # Display a tip
        puts " You can quit a game with the 'quit' command\n\n"

        # Display the board
        @board.display
        puts "\n"
    end
end
