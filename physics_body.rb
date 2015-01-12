require 'matrix'
require_relative 'physics_bit'
class PhysicsBody

  attr_accessor :id, :x, :y, :width, :height, :bitmask
  def initialize(id, x,y, width, height, bitmask = PhysicsBit::ALL)
    @id = id
    @x = x
    @y = y
    @width = width
    @height = height
    @bitmask = bitmask
  end

  def receive(sender, message)
    if message.type == :object_position && message.data[:id] == @id
      @x = message.data[:vector][0]
      @y = message.data[:vector][1]
    end
  end

end
