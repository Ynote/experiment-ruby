class Square
    attr_accessor :line, :column, :state

    def initialize(line, column)
        @line		= line
        @column		= column
        @state		= nil
    end

    def display
        if @state == :player_1
            print "|O|"
        elsif @state == :player_2
            print "|X|"
        else
            print "|_|"
        end
    end
end
