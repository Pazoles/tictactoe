# Player-related functionality
class Player
    attr_accessor :name, :move

    # initialize
    def initialize(name="Unknown", move, board)

        # select X or O
        raise "You must choose X or O" unless move.is_a?(Symbol)
        @name = name
        @move = move
        @board = board
    end

    # get_move
    def get_move

        # loop until broken
        loop do

            # ask_for_move
            space = ask_for_move

            # IF validate_move is true
            if validate_move(space)

                # IF move is placeable
                if @board.add_move(space, @move)

                    # break the loop
                    break
                end
            end
        end
    end

    # ask_for_move
    def ask_for_move

        # display message asking for get_move
        puts "#{@name} (#{@move}), enter your move in the form x,y:"
        print "> "

        # collect player entry from command line
        gets.strip.split(",").map(&:to_i)
    end

    # validate_move
    def validate_move(space)

        # UNLESS move corresponds to a valid position on the Board
        if space.is_a?(Array) && space.size == 2
            true
        else

            # display error message
            puts "Make sure your move is in the right format: x,y"
        end
    end


    def computer_move

        if @board.board_space_available_silent?([1,1])
            @board.add_move([1,1],@move)

        elsif @board.board_space_available_silent?([0,0])
            @board.add_move([0,0],@move)

        elsif @board.board_space_available_silent?([1,2])
            @board.add_move([1,2],@move)

        elsif @board.board_space_available_silent?([2,2])
            @board.add_move([2,2],@move)

        elsif @board.board_space_available_silent?([0,2])
            @board.add_move([2,1],@move)

        elsif @board.board_space_available_silent?([0,2])
            @board.add_move([0,2],@move)

        elsif @board.board_space_available_silent?([2,0])
            @board.add_move([2,0],@move)
        end
    end
end
