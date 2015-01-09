require_relative 'camera_filter'
class SmoothMoveCameraFilter < CameraFilter

  attr_accessor :target_x, :target_y, :speed_x, :speed_y
  def initialize(target_x, target_y, width, height, speed_x = 1, speed_y = 1, scale_x = 1, scale_y = 1, rot = 0)
    super(width, height, 0, 0, scale_x, scale_y, rot)
    @target_x = target_x
    @target_y = target_y
    @speed_x = speed_x
    @speed_y = speed_y
    puts "end"
  end

  def filter(sprites)
    if self.translate_x+@speed_x <= @target_x-200
      self.translate_x += @speed_x
    elsif self.translate_x-@speed_x >= @target_x+200
      self.translate_x -= @speed_x
    end

    if self.translate_y+@speed_y <= @target_y
      self.translate_y += @speed_y
    elsif self.translate_y-@speed_y >= @target_y
      self.translate_y -= @speed_y
    end
      
    puts self.translate_x
    super(sprites)
  end
end
