class Tile
  attr_writer :bomb, :flagged

  def initialize
    @bomb = false
    @flagged = false
    @hidden = true
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

end
