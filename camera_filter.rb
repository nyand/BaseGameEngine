class CameraFilter

  attr_accessor :translate_x, :translate_y, :scale_x, :scale_y, :rot, :width, :height
  def initialize(width, height, translate_x = 0, translate_y = 0, scale_x = 1, scale_y = 1, rot = 0)
    @width = width
    @height = height
    @translate_x = translate_x
    @translate_y = translate_y
    @scale_x = scale_x
    @scale_y = scale_y
    @rot = rot
  end

  def filter(sprites)
    transformed = []
    sprites.each do |sprite|
      clone = sprite.clone
      clone.x *= @scale_x
      clone.y *= @scale_y
      clone.x -= @translate_x*@scale_x
      clone.y -= @translate_y*@scale_y
      clone.scale_x *= @scale_x
      clone.scale_y *= @scale_y
      #code for rotation - matrix rotation
      transformed << clone
    end
    transformed
  end
  
end
