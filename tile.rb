class Tile
  DELTAS = [
    [-1,-1],
    [-1, 0],
    [0, -1],
    [-1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [1, 1],
  ].freeze

  attr_reader :pos

  def initialize(board, pos)
    @board, @pos = board, pos

    @bombed, @visited, @flagged = false, false, false
  end

  def bombed?
    @bombed
  end

  def visited?
    @visited
  end

  def flagged?
    @flagged
  end

  def touching_bombs
    touching.select(&:bombed?).count
  end

  def visit
    return self if flagged?
    return self if visited?

    @visited = true
    touching.each(&:visit) if !bombed? && touching_bombs == 0

    self
  end

  def inspect
    {
      pos: pos,
      bombed: bombed?,
      flagged: flagged?,
      visited: visited?
    }.inspect
  end

  def touching
    adj_coords = DELTAS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |row, col|
      [row, col].all? do |coord|
        coord.between?(0, @board.grid_size - 1)
      end
    end

    adj_coords.map { |pos| @board[pos] }
  end

  def plant_bomb
    @bombed = true
  end

  def render
    if flagged?
      " F "
    elsif visited?
      touching_bombs == 0 ? " _ " : " " + touching_bombs.to_s + " "
    else
      " * "
    end
  end

  def reveal
    if flagged?
      bombed? ? "F" : "T"
    elsif bombed?
      visited? ? "X" : "B"
    else
      touching_bombs == 0 ? "_" : touching_bombs.to_s
    end
  end

  def toggle_flag
    @flagged = !@flagged unless @visited
  end
end
