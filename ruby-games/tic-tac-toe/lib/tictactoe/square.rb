require_relative 'board'

module TicTacToe
    class Square

        attr_accessor :row, :column, :owner, :board

        def initialize(row, column, board)
            @row    = row
            @column = column
            @owner  = nil
            @board  = board
        end

        def display
            if @owner.nil?
                print "|     |"
            else
                print "|  #{@owner.symbol}  |"
            end
        end
    end
end
