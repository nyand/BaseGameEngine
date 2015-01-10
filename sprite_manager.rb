class SpriteManager

  def initialize
    @sprites = []
  end

  def add(sprite)
    @sprites << sprite
  end
  
  def remove(sprite)
    @sprites.remove(sprite)
  end

  def sprites
    clones = []
    @sprites.each { |sprite| clones << sprite.clone }
    clones
  end

  def update
    @sprites.each { |sprite| sprite.update }
  end

  def receive_message(sender, message)
    
  end

end
