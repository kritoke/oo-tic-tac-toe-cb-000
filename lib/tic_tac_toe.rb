class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8], # Last row
    [0,4,8], # First Diagnoal
    [2,4,6], # Second Diagnoal
    [0,3,6], # First Column
    [1,4,7], # Second Column
    [2,5,8] # Third Column
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def valid_move?(index)
    if !index.between?(0,8)
      false
    elsif position_taken?(index)
      false
    else
      true
    end
  end

  def position_taken?(index)
    if ((@board[index] == (" ")) || (@board[index] == ("")))
      false
    elsif @board[index] == nil
      false
    else
      true
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "Invalid choice."
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      move(index, current_player)
      display_board
    end
  end

  def turn_count
    count = 0
    @board.each do |entry|
      count += 1  if (entry == 'X' || entry == 'O')
    end
    count
  end

  def current_player
    if turn_count.even?
      'X'
    elsif turn_count == 0
      'X'
    else
      'O'
    end
  end

  def won?
    checked_board = @board.reject { |element| [' '].include? element } # make a blank array if empty @board
    if checked_board.empty?
      return false
    end

    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination # return the win_combination indexes that won.
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination # return the win_combination indexes that won.
      end
    end
    return false
  end

  def full?
    checked_board = @board.reject { |element| ['X', 'O'].include? element }
    true if checked_board.empty?
  end

  def draw?
    if !won? && full?
      true
    else
      false
    end
  end

  def over?
    if won?
      true
    elsif draw?
      true
    elsif !full?
      false
    end
  end

  def winner
    if !won?
      nil
    elsif @board[won?[0]] == 'X'
      "X"
    elsif @board[won?[0]] == 'O'
      "O"
    end
  end

  def play
    until over? do
      turn
    end
    puts "Congratulations #{winner}!" if winner != nil
    puts "Cat's Game!" if draw?
  end
end
