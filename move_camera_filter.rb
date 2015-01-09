require_relative 'camera_filter'
class MoveCameraFilter < CameraFilter

  attr_accessor :target_x, :target_y, :speed_x, :speed_y
  def initialize(target_x, target_y, speed_x = 1, speed_y = 1, scale_x = 1, scale_y = 1, rot = 0)
    super(0, 0, scale_x, scale_y, rot)
    @target_x = target_x
    @target_y = target_y
    @speed_x = speed_x
    @speed_y = speed_y
  end

  def filter(sprites)
    if @translate_x+@speed_x <= @target_x
      @translate_x += @speed_x
    elsif @translate_x-@speed_x >= @target_x
      @translate_x -= @speed_x
    end

    if @translate_y+@speed_y <= @target_y
      @translate_y += @speed_y
    elsif @translate_y-@speed_y >= @target_y
      @translate_y -= @speed_y
    end
      
    super(sprites)
  end
end
