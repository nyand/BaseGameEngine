class Sprite < GameObject

  attr_accessor :id, :sprite, :x, :y, :z, :rot, :scale_x, :scale_y
  def initialize(id, sprite, x = 0, y = 0, z = 0, scale_x = 1, scale_y = 1, rot = 0)
    @id = id
    @sprite = sprite 
    @x = x
    @y = y
    @z = z
    @scale_x = scale_x
    @scale_y = scale_y
    @rot = rot
  end

  def receive(sender, message)
    if message.type == :object_position && message.data[:id] == @id
      @x = message.data[:vector][0]
      @y = message.data[:vector][1]
    end
  end
end
