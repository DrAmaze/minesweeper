require_relative 'tile'

class Board
  attr_reader :grid_size, :num_bombs

  def initialize(num_bombs = 10, grid_size = 9)
    @num_bombs, @grid_size = num_bombs, grid_size

    generate_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def render(reveal = false)
    @grid.map do |row|
      row.map do |tile|
        reveal ? tile.reveal : tile.render
      end.join("")
    end.join("\n")
  end

  def reveal
    render(true)
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bombed? && tile.visited? }
  end

  def won?
    @grid.flatten.all? { |tile| tile.bombed? != tile.visited? }
  end

  private

  def generate_board
    def generate_board
    @grid = Array.new(@grid_size) do |row|
      Array.new(@grid_size) { |col| Tile.new(self, [row, col]) }
    end

    plant_bombs
  end

  def plant_bombs
    planted = 0

    while planted < @num_bombs
      pos = Array.new(2) { rand(@grid_size) }
      tile = self[pos]
      next if tile.bombed?

      tile.plant_bomb
      planted +=  1
    end

    nil
  end
end
