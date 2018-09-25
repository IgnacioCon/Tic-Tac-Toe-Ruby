
class TicTacToe

    attr_accessor :board
    attr_accessor :turns_taken
    attr_accessor :current_player
    attr_accessor :winner

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
        @turns_taken = 0
        @current_player = "X"
        @winner = ""
    end

    def print_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]}  "
        puts " --------- "
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]}  "
        puts " --------- "
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]}  "

    end

    #converts user input to integer to be used to access the board values
    def input_to_index(input)
        input = input.to_i - 1
    end
    
    #checks if the position is taken
    def position_taken? (index)
        @board[index] != " " ? true : false
    end

    def valid_move? (index)
        (@board[index] != nil) && !(position_taken? index) ? true : false            
    end

    #tells user to select a position on the board, converts it to an integer
    #checks if the selection is a valid move, if yes place the current players move on the board
    #increase the number of turns taken, and switch players
    #if move is invalid, then tell the user that the position is either taken or an invalid move
    def take_a_turn
        puts "Select a position on the board from 1 to 9: "
        user_input = gets.chomp
        user_input = input_to_index(user_input)
        was_valid_move = valid_move? user_input

        if was_valid_move
            @board[user_input] = @current_player
            @turns_taken += 1
            @current_player = @current_player == "X" ? "O" : "X" 
        else
            if position_taken? user_input 
                puts "That position is taken!" 
            else 
                "Invalid move!"
            end
        end
    end

    #Check to see if the game has been won, using the WIN_COMBINATIONS constant declared
    #For each win combination we check the value of the position on the board too see if we have three in a row
    #For either X or O values, if we don't have a win condition then we return false
    def won?
        WIN_COMBINATIONS.each do |comb|
            if (@board[comb[0]] == "X") && (@board[comb[1]] == "X") && (@board[comb[2]] == "X")
                @winner = "X"
                return true
            elsif (@board[comb[0]] == "O") && (@board[comb[1]] == "O") && (@board[comb[2]] == "O")
                @winner = "O"
                return true
            else
                return false
            end
        end
    end
    
    #see if full
    def full?
        @turns_taken == 9 ? true : false
    end
    
    #see if draw, if it is full and game has not been won
    def draw?
        (full? && !won?) ? true : false
    end

    #check if game is over, if it has been won, if it is a draw, or if the board is full
    def game_is_over?
        (won? || draw? || full?) ? true : false
    end

    #get the winner of the game
    def winner
        return @winner != "" ? "#{@winner} has won the game!" : "No winner yet!"
    end

    #main loop to play the game, until the game is over, keep taking turns
    #then check if the game has been won, declare winner,
    #else if a draw, then give option to play again
    def play
        until game_is_over? do
            take_a_turn
            print_board
        end


        if won?
            winner
        else
            play_again = ""
            puts "The game has ended in a draw! Would you like to play again? \n Press y for yes, n for no"
            play_again = gets.chomp.downcase

            until (play_again == "y" || play_again == "n") do
                puts "Invalid choice: Please enter y or n."
                play_again = gets.chomp.downcase    
            end

            if play_again == "y"
                clean_board
                @turns_taken = 0
                @current_player = @current_player == "X" ? "O" : "X"
                puts "Since it was a Draw, Player #{@current_player} will begin to move this round."
                play
            else
                puts "Thank you for playing!"
            end
        end
    end

    #Method gives a welcome message and begins the main loop
    def start
        puts "Welcome! Let's play Tic-Tac-Toe"
        print_board
        play
    end

    #clean the board for a new game
    def clean_board
        @board = [" "," "," "," "," "," "," "," "," "]
    end
end


tic = TicTacToe.new

tic.start