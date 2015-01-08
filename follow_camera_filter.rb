require_relative 'camera_filter'

class FollowCameraFilter < CameraFilter

  attr_accessor :follow_id, :width, :height
  def initialize(width, height, follow_id = nil, translate_x = 0, translate_y = 0, scale_x = 1, scale_y = 1, rot = 0)
    super(translate_x, translate_y, scale_x, scale_y, rot)
    @follow_id = follow_id
    @width = width
    @height = height
  end


  def filter(sprites)
    transformed = []
    sprites.each do |sprite|

      clone = sprite.clone
      clone.x *= @scale_x
      clone.y *= @scale_y
      if @follow_id && clone.id == @follow_id
        @translate_x = clone.x + clone.sprite.width/2 - width/2
        @translate_y = clone.y + clone.sprite.height/2 - height/2
      end
      clone.x -= @translate_x
      clone.y -= @translate_y
      clone.scale_x *= @scale_x
      clone.scale_y *= @scale_y
      #code for rotation - matrix rotation
      transformed << clone
    end
    transformed
  end
end
