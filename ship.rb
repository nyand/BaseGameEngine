require 'matrix'
require_relative 'game_object'
class Player < GameObject

  attr_reader :position, :velocity
  def initialize(x, y)
    @position = Vector[x, y]
    @velocity = Vector[0, 0]
  end 

  def update
    @position += @velocity 
  end

  def draw

  end

  def receive(sender, message)
    if sender.class == KeyboardPublisher 
      if message[:type] == :down
        case message[:button]
        when Gosu::KbW
          @velocity += Vector[0, -1]
        when Gosu::KbS
          @velocity += Vector[0, 1]
        when Gosu::KbD
          @velocity += Vector[1, 0]
        when Gosu::KbA
          @velocity += Vector[-1, 0]
        end
      end

      if message[:type] == :up
        case message[:button]
        when Gosu::KbW
          @velocity += Vector[0, 1]
        when Gosu::KbS
          @velocity += Vector[0, -1]
        when Gosu::KbD
          @velocity += Vector[-1, 0]
        when Gosu::KbA
          @velocity += Vector[1, 0]
        end
      end  
    end
  end
end
