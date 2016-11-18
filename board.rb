require_relative "tile"

class Board
  attr_reader :grid

  GRID_DIM = 9
  BOMB_COUNT = 10

  def self.create_grid
    Array.new(GRID_DIM) do
      Array.new(GRID_DIM) { Tile.new }
    end
  end

  def initialize
    @grid = Board.create_grid
    populate
    set_fringes
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
    BOMB_COUNT.times do
      random_row = (0...GRID_DIM).to_a.sample
      random_col = (0...GRID_DIM).to_a.sample
      pos = [random_row, random_col]

      bomb_placed?(pos) ? redo : place_bomb(pos)
    end
  end

  def set_fringes
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        pos = [row_idx, col_idx]
        tile.adj_bombs = count_adj_bombs(pos)
      end
    end
  end

  def count_adj_bombs(pos)
    neighbors = top_tiles(pos) + side_tiles(pos) + bottom_tiles(pos)
    neighbors.count { |tile| tile && tile.bomb? }
  end

  def top_tiles(pos)
    row, col = pos
    [grid[row - 1][col - 1], grid[row - 1][col], grid[row - 1][col + 1]]
  end

  def bottom_tiles(pos)
    row, col = pos
    [grid[row + 1][col - 1], grid[row + 1][col], grid[row + 1][col + 1]]

  end

  def side_tiles(pos)
    row, col = pos
    [grid[row][col - 1], grid[row][col + 1]]
  end

  def bomb_placed?(pos)
    self[pos].bomb?
  end

  def place_bomb(pos)
    self[pos].make_bomb
  end

  def render

  end
end
