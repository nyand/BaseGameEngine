require 'matrix'
require_relative 'game_object'
class Player < GameObject

  attr_reader :position, :velocity, :direction
  def initialize(id, x, y)
    super id
    @position = Vector[x, y]
    @velocity = Vector[0, 0]
    @direction = nil
  end 

  def update
    @prev = Vector[@position[0], @position[1]]
    @position += @velocity 

    message = {id: @id, vector: @position}
    EventBus.push(:object_position, message)
  end

  def draw

  end

  def receive(sender, message)
    if message.type == :physics_manager
      if message.data[:object1] == self.id 
        @position = @prev 
        update_message = {id: @id, vector: @position}
        EventBus.push(:object_position, update_message)
      end
    end

    if message.data[:type] == :down
      case message.data[:button]
      when Gosu::KbW
        @velocity = Vector[0, -2]
        @direction = :up
      when Gosu::KbS
        @velocity = Vector[0, 2]
        @direction = :down
      when Gosu::KbD
        @velocity = Vector[2, 0]
        @direction = :right
      when Gosu::KbA
        @velocity = Vector[-2, 0]
        @direction = :left
      end
    end

    if message.data[:type] == :up
      case message.data[:button]
      when Gosu::KbW
        @velocity = Vector[@velocity[0], 0] if @direction == :up
      when Gosu::KbS
        @velocity = Vector[@velocity[0], 0] if @direction == :down
      when Gosu::KbD
        @velocity = Vector[0, @velocity[1]] if @direction == :right
      when Gosu::KbA
        @velocity = Vector[0, @velocity[1]] if @direction == :left
      end
    end  
  end
end
