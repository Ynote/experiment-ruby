require_relative 'square'

class Board

    attr_accessor :squares, :lines, :columns

    def initialize(lines = 6, columns = 7, win_number = 4)
        @squares = []
        @lines = lines
        @columns = columns
        @win_number = win_number
    end

    private
    def create_empty_line(i)
        line = []
        @columns.times do |j|
            square = Square.new(i,j)
            line.push square
        end
        @squares.push line
    end

    def has_required_identical_following_squares?(array)
        same_item = 0
        previous_square = array.first

        array.each do |square|
            if square.state == previous_square.state && !square.state.nil?
                same_item += 1
            else
                same_item = 1
            end
            if same_item == @win_number
                return true
            end
            previous_square = square
        end
        return false
    end

    def has_required_identical_diagonal_squares?(begin_index, last_index, break_index, direction)
        column_first_index = begin_index
        line_first_index = 0

        @lines.times do |i|
            array = []

            if column_first_index < - @columns
                index =  last_index
                line_first_index += 1
            else
                index = column_first_index
            end

            @squares[line_first_index..@squares.length].each do |line|
                array.push line[index]
                if index == break_index
                    break
                end

                if direction == :left
                    index -= 1
                elsif direction == :right
                    index += 1
                end
            end

            if has_required_identical_following_squares?(array)
                return true
            end

            column_first_index -= 1
        end
        return false
    end

    public
    def create
        @lines.times { |i| create_empty_line(i) }
    end

    def display
        @squares.reverse_each do |line|
            line.each do |square|
                square.display
            end
            puts "\n"
        end
        puts "\n"
        @columns.times { |i| print " #{i+1} "}
        puts "\n"
    end

    def has_required_vertical_identical_squares?
        @columns.times do |i|
            array = []
            @squares.each do |line|
                array.push line[i]
            end

            if has_required_identical_following_squares?(array)
                return true
            end
        end
        return false
    end

    def has_required_horizontal_identical_squares?
        @squares.each do |line|
            if has_required_identical_following_squares?(line)
                return true
            end
        end
        return false
    end

    def has_required_rtl_diagonal_identical_squares?
        has_required_identical_diagonal_squares?(-@win_number, -@columns, -1, :right)
    end

    def has_required_ltr_diagonal_identical_squares?
        has_required_identical_diagonal_squares?(-1, 0, -@columns, :left)
    end

    def is_full?
        @squares.each do |line|
            line.each do |square|
                if square.state.nil?
                    return false
                end
            end
        end
        return true
    end
end
