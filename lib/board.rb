# The board which players interact with
class Board

    # initialize Board
    def initialize
        # set up the data structure
        @board = Array.new(3){Array.new(3)}
    end

    def render
        puts
        puts " | 0 | 1 | 2 |"
        puts "--------------"

        # loop through data structure with labels on left side
        @board.each_with_index do |row, index|
            print(index)
            row.each do |cell|

                print("|")
                # display previously placed Xs and Os, else blank
                cell.nil? ? print(" - ") : print(" "+cell.to_s+" ")
            end
            print("|")
            puts
            puts "--------------"
        end
        puts
    end


    # add_move
    def add_move(space, move)

        # IF move_location_valid?
        if move_location_valid?(space)
            @board[space[0]][space[1]] = move

            # accept move
            true
        else
            false
        end
    end


    # is this a valid move?
    def move_location_valid?(space)

        # Is it within_board_space
        if within_board_space?(space)

        # Is the board_space_available?
            board_space_available?(space)
        end
    end

    # is the move within range?
    def within_board_space?(space)

        # Unless move corresponds to space on the 3x3 grid
        if (0..2).include?(space[0]) && (0..2).include?(space[1])
            true
        else
            # display error message
            puts "Not a valid move - out of range"
        end
    end

    # is the space available??
    def board_space_available?(space)

        # unless space is not occupied
        if @board[space[0]][space[1]].nil?
            true
        else

            # display error message
            puts "Space is already taken"
        end
    end

    def board_space_available_silent?(space)

        # unless space is not occupied
        if @board[space[0]][space[1]].nil?
            true
        else

            # display error message
            false
        end
    end

    # win_conditions?
    def win_conditions?(move)

        # Diagonal, vertical, or horizontal wins?
        win_diagonal?(move) || win_vertical?(move) || win_horizontal?(move)
    end

    # win_diagonal?
    def win_diagonal?(move)

        # check if move has three in a row diagonally
        diagonals.any? do |diag|
            diag.all?{|cell| cell == move }
        end
    end

    # win_vertical?
    def win_vertical?(move)

        # check if move has three in a row vertically
        verticals.any? do |vert|
            vert.all?{|cell| cell == move }
        end
    end

    # win_horizontal?
    def win_horizontal?(move)

        # check if move has three in a row horizontally
        horizontals.any? do |horz|
           horz.all?{|cell| cell == move }
       end
    end

    # diagonals
    def diagonals

        # return the diagonal spaces
        [[ @board[0][0],@board[1][1],@board[2][2] ],[ @board[2][0],@board[1][1],@board[0][2] ]]
    end

    # verticals
    def verticals

        # return the vertical spaces
        @board
    end

    # horizontals
    def horizontals

        # return the horizontal moves
        horizontals = []
        3.times do |i|
            horizontals << [@board[0][i],@board[1][i],@board[2][i]]
        end
        horizontals
    end

    # tie?
    def tie?

        # is a win still possible?
        @board.all? do |row|
            row.none?(&:nil?)
        end
    end
end
