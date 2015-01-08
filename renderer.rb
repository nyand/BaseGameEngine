class Renderer

  def initialize(draw_context)
    @context = draw_context
  end

  def draw(sprites)
    sprites.each do |sprite|
      puts "(#{sprite.x},#{sprite.y},#{sprite.z}) - #{sprite.scale_x} - #{sprite.scale_y}"
      sprite.sprite.draw(sprite.x, sprite.y, sprite.z, sprite.scale_x, sprite.scale_y)
    end
  end
end
