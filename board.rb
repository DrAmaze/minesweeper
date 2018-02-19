require_relative 'tile'

class Board
  def initialize(num_bombs = 10, grid_size = 9)
    @num_bombs, @grid_size = num_bombs, grid_size
    populate_bombs(num_bombs)
  end

  def populate_bombs(n)

  end
end
