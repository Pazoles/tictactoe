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
