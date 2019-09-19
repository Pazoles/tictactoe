# [Tic Tac Toe](https://en.wikipedia.org/wiki/Tic-tac-toe) #

This is a simple Tic Tac Toe program written in Ruby, where you are able to play against a (simple) computer using the command line.

Enter a new game using:   `$ ./bin/tictactoe`

Intermediate files contain a flowchart, pseudocode, and a single file version of this app.


## How it works ##

1. On entering a game, it will prompt you to choose X or O. (X always goes first.)
2. At the beginning of each turn, it will ask you for the coordinates of your move in an X,Y format. The columns and rows are labeled, starting with 0.
3. After validating that your move is both legal and available, a marker will be placed on the board and the computer will make its move.
4. Play will continue until one player wins, or the board is full. There is a prompt for a rematch if you would like to play again.


## Future improvements ##

1. Create test suite using rspec to ensure expected results as the app grows more complicated.
2. Add increasing difficulty levels to AI, using either preset strategies or by exploring the board to find winning moves.
3. Add options for 0 or 2 human players.
4. Recognize when a tie is inevitable, and end the game before the board is full.
5. Add color to highlight winning move and differentiate player markers.

