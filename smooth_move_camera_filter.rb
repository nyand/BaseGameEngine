require_relative 'camera_filter'
class SmoothMoveCameraFilter < CameraFilter

  attr_accessor :target_x, :target_y, :speed_x, :speed_y, :padding_x, :padding_y
  def initialize(target_x, target_y, width, height, padding_x = 0, padding_y = 0, speed_x = 1, speed_y = 1, scale_x = 1, scale_y = 1, rot = 0)
    super(width, height, 0, 0, scale_x, scale_y, rot)
    @target_x = target_x
    @target_y = target_y
    @speed_x = speed_x
    @speed_y = speed_y
    @padding_x = padding_x
    @padding_y = padding_y
  end

  def filter(sprites)
    if self.translate_x+@speed_x <= @target_x-padding_x
      self.translate_x += @speed_x
    elsif self.translate_x-@speed_x >= @target_x+padding_x
      self.translate_x -= @speed_x
    end

    if self.translate_y+@speed_y <= @target_y-padding_y
      self.translate_y += @speed_y
    elsif self.translate_y-@speed_y >= @target_y+padding_y
      self.translate_y -= @speed_y
    end
      
    super(sprites)
  end
end
