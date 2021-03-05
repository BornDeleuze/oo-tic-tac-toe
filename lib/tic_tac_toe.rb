require 'pry'
class TicTacToe
    attr_accessor :choice, :combo
    
    def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
    @combo = []
    end

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(place)
        choice =  place.to_i - 1
        # @choice = choice
        choice 
    end

    def move(choice, token = "X")
        @board[choice] = token
    end

    def position_taken?(index)
        result = true
        if @board[index].eql?(" ")
            result = false
        end
        result
    end

    def valid_move?(position)
        move_valid = false
        # if (position === (0..8)) && (@board[position].eql?(" "))
        if position_taken?(position) == false && position.between?(0,8)
        move_valid = true
        end
        move_valid
    end

    # {|i| i == "str1" || i == "str3" || i == "str5"}

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end
    
    def current_player
        x_turn = "X"
        o_turn = "O"
        if turn_count % 2 == 0 
            x_turn
        else
            o_turn
        end
    end

    def turn
        # token = current_player
        puts "Make your move"
        input = gets
        position = input_to_index(input) 
        if valid_move?(position)
            token = current_player
            move(position, token)
            display_board
        else
            turn
        end
    end

# game is won if the X or O occupies all of the indexes in any WIN_COMBO array 
 #if the board indexes for X match any of the win comboniations then win
    
    def won?
        status = false
            WIN_COMBINATIONS.each do |combo|
                if
                    @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && position_taken?(combo[0])
                    status = combo
                    @combo = combo
                    # binding.pry
                end
            end
        status
    end

    def full?
        status = true
        if @board.any? {|position| position == " "} 
            status = false
        end
        status
    end

    def draw?
        status = false
        if self.full? == true && self.won? == false
            status = true
        end
        status
    end
    def over?
        status = false
        if self.draw? == true || self.won? != false
             status = true
        end
        status
    end

    def winner
        winner = nil
        if winning_combo = self.won?
            winner = @board[winning_combo[0]]
        end
        winner
    end

    def play
        until self.over? == true
            self.turn
        end
        if self.won?
            puts "Congratulations #{winner}!"
        else self.draw? == true
            puts "Cat's Game!"
        end
    end

end