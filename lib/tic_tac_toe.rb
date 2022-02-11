class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5], # Middle row
        [6,7,8], # Bottom row
        [0,3,6], # Left side
        [1,4,7], # Down the center
        [2,5,8], # Right side
        [0,4,8], # Diagonal from top left
        [2,4,6]  # Diagonal from top right 
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
        self.play
    end

    # #### HELPER METHODS #### 

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end


    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(position)
        position >=0 && position < 9 && !position_taken?(position)
    end

    def turn_count
        @board.filter{ |spot| spot != " " }.length
    end

    def current_player
        self.turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Enter a space number from 1 to 9"
        input = gets
        index = input_to_index(input)
        if valid_move?(index)
            self.move(index, self.current_player)
            self.display_board
        else
            self.turn
        end
    end

    def won?
        x_indices = []
        o_indices = []
        @board.each_with_index do |item, idx|
            if item == "X"
                x_indices << idx
            elsif item == "O"
                o_indices << idx
            end
        end

        WIN_COMBINATIONS.each do |combo|
            if x_indices.include?(combo[0]) && x_indices.include?(combo[1])  && x_indices.include?(combo[2])
                return combo
            elsif o_indices.include?(combo[0]) && o_indices.include?(combo[1]) && o_indices.include?(combo[2])
                return combo
            end
        end
        nil
    end

    def full?
        !@board.include?(" ")
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.full? || self.won?
    end

    def winner
        if won?
            return @board[won?[0]]
        else
            return nil
        end
    end 

    # #### GAME LOOP ####

    def play 
        until over? do
            self.turn
        end 
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
     end

end

#new_game = TicTacToe.new
