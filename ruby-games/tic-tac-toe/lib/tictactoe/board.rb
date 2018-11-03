require_relative 'square'

module TicTacToe
    class Board

        attr_accessor :rows, :columns, :grid

        def initialize(rows = 3, columns = 3)
            @rows           = rows
            @columns        = columns
            @grid           = []
            @win_lines      = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        end


        public
        def create
            @rows.times { |i| create_empty_row(i) }
        end

        def display
            @grid.each_with_index do |row, index|
                print "\n     a      b      c   \r" if index == 0
                print "\n  |-----||-----||-----|\n"
                print (index + 1).to_s + " "
                row.each_with_index do |square, i|
                    square.display
                    if i > 0 and i%3 == 0
                        print "\n"
                    end
                end
                if row == @grid.last
                    print "\n  |-----||-----||-----|\n"
                end
            end
        end

        def get_square(row, column)
            return @grid[row][column]
        end

        def has_winning_line?
            @win_lines.each do |l|
                line = (0..2).map { |n| @grid.flatten[l[n]].owner.nil? ? ' ' : @grid.flatten[l[n]].owner.symbol }.inject('', :+)
                return true if line == 'OOO' or line == 'XXX'
            end
            false
        end

        def is_full?
            @grid.flatten.each do |square|
                return false if square.owner.nil?
            end
            true
        end


        private
        def create_empty_row(i)
            line = []
            @columns.times do |j|
                square = Square.new(i,j, self)
                line.push square
            end
            @grid.push line
        end

    end
end
