class ZLayerFilter

  def initialize

  end

  def filter(sprites)
    sprites.each do |sprite|
      sprite.z = sprite.y 
    end 
    sprites
  end
end
