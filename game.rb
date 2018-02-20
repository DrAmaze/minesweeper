require 'yaml'
require_relative 'board'

class Game
  LAYOUTS = {
    small: { grid_size: 9, num_bombs: 10 },
    medium: { grid_size: 16, num_bombs: 40 },
    large: { grid_size: 32, num_bombs: 160 }
  }.freeze

  def initialize(size)
    layout = LAYOUTS[size]
    @board = Board.new(layout[:grid_size], layout[:num_bombs])

    play
  end

  def play
    until @board.won? || @board.lost?
      puts @board.render

      action, pos = get_move
      perform_move(action, pos)
    end

    if @board.won?
      puts "You are a champion!"
    elsif @board.lost?
      puts "_,.*'BABOOM'*.,_"
      puts @board.reveal
    end
  end

  private

  def get_move
    puts "what action? type 'f' for flag, 'v' for visit, or 's' for save"
    action = gets.chomp

    puts "which tile? (i.e. 'row,column')"
    row, col = gets.chomp.split(",")

    [action, [row.to_i, col.to_i]]
  end

  def perform_move(action, pos)
    tile = @board[pos]

    case action
    when "f"
      tile.toggle_flag
    when "v"
      tile.visit
    when "s"
      save
    else
      puts "invalid entry"
    end
  end

  def save
    puts "Enter filename to save:"
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end
end

if $PROGRAM_NAME == __FILE__
  case ARGV.count
  when 0
    Game.new(:small).play
  when 1
    YAML.load_file(ARGV.shift).play
  end
end
