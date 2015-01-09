class SmoothFollowFilter
  
  attr_accessor :follow_id
  def initialize(follow_id)
    @follow_id = follow_id
  end

  def track(sprites, move_camera)
    sprites.each do |sprite|
      if @follow_id && sprite.id == @follow_id
        move_camera.target_x = sprite.x + sprite.sprite.width/2 - move_camera.width/2
        move_camera.target_y = sprite.y + sprite.sprite.height/2 - move_camera.height/2
      end
    end
  end
end
