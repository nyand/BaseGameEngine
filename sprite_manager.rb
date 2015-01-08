class SpriteManager

  attr_reader :sprites
  def initialize
    @sprites = []
  end

  def add(sprite)
    @sprites << sprite
  end
  
  def remove(sprite)
    @sprites.remove(sprite)
  end

  def update
  end

  def receive_message(sender, message)
    
  end

end
