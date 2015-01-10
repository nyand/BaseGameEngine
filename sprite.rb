class Sprite

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

  def update
  end
end
