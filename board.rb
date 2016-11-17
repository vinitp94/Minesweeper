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
    populate!
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def populate!
    BOMB_COUNT.times do
      random_row = (0...GRID_DIM).to_a.sample
      random_col = (0...GRID_DIM).to_a.sample
      pos = [random_row, random_col]

      bomb_placed?(pos) ? redo : place_bomb(pos)
    end
  end

  def bomb_placed?(pos)
    self[pos].bomb?
  end

  def place_bomb(pos)
    self[pos].make_bomb
  end
end
