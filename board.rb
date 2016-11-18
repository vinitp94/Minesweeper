require_relative "tile"

class Board
  attr_reader :grid
  attr_accessor :bomb_hash

  GRID_DIM = 9
  BOMB_COUNT = 10

  def self.create_grid
    Array.new(GRID_DIM) do
      Array.new(GRID_DIM) { Tile.new }
    end
  end

  def initialize
    @bomb_hash = Hash.new(0)
    @grid = Board.create_grid
    populate
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def populate
    place_all_bombs
    set_adj_counts
  end

  def place_all_bombs
    BOMB_COUNT.times do
      grid_range = (0...GRID_DIM).to_a
      random_row, random_col = grid_range.sample, grid_range.sample
      pos = [random_row, random_col]

      bomb_placed?(pos) ? redo : place_bomb(pos)
    end
  end

  def set_adj_counts
    fill_bomb_hash
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        pos = [row_idx, col_idx]
        tile.adj_bombs = bomb_hash[pos]
      end
    end
  end

  def fill_bomb_hash
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        increment_neighbors(row_idx, col_idx) if tile.bomb?
      end
    end
  end

  def increment_neighbors(row, col)
    [-1, 0, 1].each do |delta_row|
      [-1, 0, 1].each do |delta_col|
        next if delta_row == 0 && delta_col == 0
        pos = [row + delta_row, col + delta_col]
        bomb_hash[pos] += 1
      end
    end
  end

  def bomb_placed?(pos)
    self[pos].bomb?
  end

  def place_bomb(pos)
    self[pos].make_bomb
  end

  def render
    grid.each do |row|
      row.each do |tile|
        print "#{tile} "
      end
      print "\n"
    end
  end

end

board = Board.new
board.render
