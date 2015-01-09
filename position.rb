require 'matrix'
require_relative 'component'

class Position < Component

  attr_reader :position
  def initialize(owner, x = 0, y = 0, z = 0)
    super(owner) 
    @position = Vector[x, y, z]
  end

  def receive(sender, message)
    
  end
end
