require_relative 'component'

class SpriteComponent < Component
  
  attr_reader :sprite
  def initialize(owner, sprite)
    super(owner)
    @sprite = sprite
  end

  def receive(sender, message)
    if message.type == :object_position && message.data[:id] == @owner.id
      @sprite.x = message.data[:vector][0]
      @sprite.y = message.data[:vector][1]
    end
  end
end
