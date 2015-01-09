require_relative 'camera_filter'

class FollowCameraFilter < CameraFilter

  attr_accessor :follow_id, :width, :height
  def initialize(width, height, follow_id = nil, translate_x = 0, translate_y = 0, scale_x = 1, scale_y = 1, rot = 0)
    super(width, height, translate_x, translate_y, scale_x, scale_y, rot)
    @follow_id = follow_id
  end


  def filter(sprites)
    transformed = []
    sprites.each do |sprite|

      sprite.x *= @scale_x
      sprite.y *= @scale_y
      if @follow_id && sprite.id == @follow_id
        @translate_x = sprite.x + sprite.sprite.width/2 - self.width/2
        @translate_y = sprite.y + sprite.sprite.height/2 - self.height/2
      end
      sprite.x -= @translate_x
      sprite.y -= @translate_y
      sprite.scale_x *= @scale_x
      sprite.scale_y *= @scale_y
      #code for rotation - matrix rotation
      transformed << sprite
    end
    transformed
  end
end
