class Game < ActiveRecord::Base

  def self.initialize_board
    rows = 9
    cols = 9

    @board = Hash.new
    for i in (0..rows-1)
      @board[i] = Array.new(cols, 0)
    end

    random_mines
    @board
  end

  def self.random_mines
    for i in (0..9)
      @board[rand(8) + 1][rand(8) + 1] = 1
    end
  end

  # def self.adjacent_mines_count(board)
  #   adjacents_hash = Hash.new
  #   board.each do |key, row|
  #     adjacents_hash[key] = Array.new
  #     row.each_with_index do |tile, col|
  #       adjacent_mines_count = 0
  #       if board[key][col] == 1
  #         adjacent_mines_count = -1
  #       else
  #         adjacent_mines_count += 1 if (key-1) >= 0 && (key-1) < 9 && (key-1) >= 0 && (key-1) < 9 && board[key-1][col-1] == 1
  #         adjacent_mines_count += 1 if (key-1) >= 0 && (key-1) < 9 && board[key-1][col] == 1
  #         adjacent_mines_count += 1 if (key-1) >= 0 && (key-1) < 9 && (col+1) >= 0 && (col+1) < 9 && board[key-1][col+1] == 1
  #         adjacent_mines_count += 1 if (col-1) >= 0 && (col-1) < 9 && board[key][col-1] == 1
  #         adjacent_mines_count += 1 if (col+1) >= 0 && (col+1) < 9 && board[key][col+1] == 1
  #         adjacent_mines_count += 1 if (key+1) >= 0 && (key+1) < 9 && (col-1) >= 0 && (col-1) < 9 && board[key+1][col-1] == 1
  #         adjacent_mines_count += 1 if (key+1) >= 0 && (key+1) < 9 && board[key+1][col] == 1
  #         adjacent_mines_count += 1 if (key+1) >= 0 && (key+1) < 9 && (col+1) >= 0 && (col+1) < 9 && board[key+1][col+1] == 1
  #       end
  #       # adjacents_hash[key] << adjacent_mines_count
  #     end
  #   end
  #
  #   adjacent_mines_count
  # end

  def self.adjacent_mines_count(board, row, col)
    adjacent_mines_count = 0
    if (row) >= 0 && (row) < 9 && (col) >= 0 && (col) < 9
      if board[row][col] == 1
        adjacent_mines_count = -1
      else
        adjacent_mines_count += 1 if (row-1) >= 0 && (row-1) < 9 && (col-1) >= 0 && (col-1) < 9 && board[row-1][col-1] == 1
        adjacent_mines_count += 1 if (row-1) >= 0 && (row-1) < 9 && board[row-1][col] == 1
        adjacent_mines_count += 1 if (row-1) >= 0 && (row-1) < 9 && (col+1) >= 0 && (col+1) < 9 && board[row-1][col+1] == 1
        adjacent_mines_count += 1 if (col-1) >= 0 && (col-1) < 9 && board[row][col-1] == 1
        adjacent_mines_count += 1 if (col+1) >= 0 && (col+1) < 9 && board[row][col+1] == 1
        adjacent_mines_count += 1 if (row+1) >= 0 && (row+1) < 9 && (col-1) >= 0 && (col-1) < 9 && board[row+1][col-1] == 1
        adjacent_mines_count += 1 if (row+1) >= 0 && (row+1) < 9 && board[row+1][col] == 1
        adjacent_mines_count += 1 if (row+1) >= 0 && (row+1) < 9 && (col+1) >= 0 && (col+1) < 9 && board[row+1][col+1] == 1
      end
    else
      return nil
    end

    adjacent_mines_count
  end

  def self.open_tiles(adjacents_hash, opened_tiles_hash, row, col)
    return if(row < 0 || row > 8 || col < 0 || col > 8 || adjacents_hash[row][col] == -1)

    if adjacents_hash[row][col] != 0
      opened_tiles_hash[row][col] = adjacents_hash[row][col]
      adjacents_hash[row][col] = -1
    elsif adjacents_hash[row][col] == 0
      opened_tiles_hash[row][col] = adjacents_hash[row][col]
      adjacents_hash[row][col] = -1
      open_tiles(adjacents_hash, opened_tiles_hash, row-1, col-1)
      open_tiles(adjacents_hash, opened_tiles_hash, row-1, col)
      open_tiles(adjacents_hash, opened_tiles_hash, row-1, col+1)
      open_tiles(adjacents_hash, opened_tiles_hash, row, col-1)
      open_tiles(adjacents_hash, opened_tiles_hash, row, col+1)
      open_tiles(adjacents_hash, opened_tiles_hash, row+1, col-1)
      open_tiles(adjacents_hash, opened_tiles_hash, row+1, col)
      open_tiles(adjacents_hash, opened_tiles_hash, row+1, col+1)
    else
      return opened_tiles_hash
    end
  end
end
