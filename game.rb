require 'yaml'
require_relative 'board'

class Game
  LAYOUTS = {
    small: { grid_size: 9, num_bombs: 10 },
    medium: { grid_size: 16, num_bombs: 40 },
    large: { grid_size: 32, num_bombs: 160 }
  }.freeze

  def initialize(size)

  end

  def play
  end

  private

  def get_move
  end

  def perform_move
  end

  def save
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
