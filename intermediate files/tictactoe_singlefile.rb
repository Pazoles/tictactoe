# Game play controls
class Game

    # initialize
    def initialize

        # set up the 3x3 board
        @board = Board.new

        # set up two players
        @player_x = Player.new("Player 1", :x, @board)
        @player_o = Player.new("Player 2", :o, @board)

        # ask for player preference
        puts "Choose X or O"
        choice = gets.strip.downcase

        # assign computer to the opposing player
        if choice == "x"
            @computer = @player_o
            @human = @player_x
        else
            @computer = @player_x
            @human = @player_o
        end

        # X goes first
        @players_turn = @player_x

    end


    # play
    def play

        # loop until game ends
        loop do

            # call the method to render Board
            @board.render

            # ask player to enter their move
            if @players_turn == @computer
                @players_turn.computer_move
            else
                @players_turn.get_move
            end

            # if the move finishes the turn, ask for rematch
            if check_game_over
                rematch
            end

            # switch players
            switch_players
        end
    end

    # check_game_over
    def check_game_over

        # win or tie
        check_win || check_tie
    end

    # check_win
    def check_win

        # If three in a row
        if @board.win_conditions?(@players_turn.move)

            # display win message
            puts "You beat the computer!"
            true
        else
            # return false and continue
            false
        end
    end

    # check_tie
    def check_tie

        # If three in a row is impossible
        if @board.tie?

            # display tie message
            puts "It's a tie"
            true
        else

            # return false and continue
            false
        end
    end

    # switch active/inactive players
    def switch_players
        if @players_turn == @player_x
            @players_turn = @player_o
        else
            @players_turn = @player_x
        end
    end

    # see if they want to play again
    def rematch
        puts "Play again?  Y/N:"
        print "> "
        response = gets.strip.downcase

        # ensure the response is in Y/N format
        if rematch_valid?(response)
            if response == 'y'
                # play new game
                t = Game.new
                t.play
            else

                # exit the game
                puts "Thanks for playing, see you next time"
                exit
            end
        end
    end

    # rematch_valid?
    def rematch_valid?(response)
        if ['y','n'].include?(response)
            true
        else

            # display error message
            puts "Not a valid selection, please enter Y or N"
        end
    end



end


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

t = Game.new
t.play
