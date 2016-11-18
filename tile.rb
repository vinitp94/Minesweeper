class Tile
  attr_writer :bomb, :flagged, :adj_bombs

  def initialize
    @bomb = false
    @flagged = false
    @hidden = true
    @adj_bombs = 0
  end

  def bomb?
    @bomb
  end

  def flagged?
    @flagged
  end

  def hidden?
    @hidden
  end

  def make_bomb
    @bomb = true
  end

  def to_s
    return "F" if flagged?
    return ""
  end
end
