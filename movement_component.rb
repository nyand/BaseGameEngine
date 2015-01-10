require 'matrix'
require_relative 'component'

class MovementComponent < Component

  attr_reader :position
  def initialize(owner, x = 0, y = 0, z = 0)
    super(owner) 
    @position = Vector[x, y, z]
    @velocity = Vector[0, 0, 0]
    @direction = nil
  end

  def update
    @prev = Vector[@position[0], @position[1], @position[2]]
    @position += @velocity
    
    message = {id: @owner.id, vector: @position}
    self.bus.push(:object_position, message)
  end

  def receive(sender, message)
    if message.type == :physics_manager
      #p message.data[:object1]
      if message.data[:object1] == @owner.id 
        @position = @prev 
        update_message = {id: @owner.id, vector: @position}
        self.bus.push(:object_position, update_message)
      end
    end

    if message.data[:type] == :down
      case message.data[:button]
      when Gosu::KbW
        @velocity = Vector[0, -2, 0]
        @direction = :up
      when Gosu::KbS
        @velocity = Vector[0, 2, 0]
        @direction = :down
      when Gosu::KbD
        @velocity = Vector[2, 0, 0]
        @direction = :right
      when Gosu::KbA
        @velocity = Vector[-2, 0, 0]
        @direction = :left
      end
    end

    if message.data[:type] == :up
      case message.data[:button]
      when Gosu::KbW
        @velocity = Vector[@velocity[0], 0, 0] if @direction == :up
      when Gosu::KbS
        @velocity = Vector[@velocity[0], 0, 0] if @direction == :down
      when Gosu::KbD
        @velocity = Vector[0, @velocity[1], 0] if @direction == :right
      when Gosu::KbA
        @velocity = Vector[0, @velocity[1], 0] if @direction == :left
      end
    end  
  end
end
