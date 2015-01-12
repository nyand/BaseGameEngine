require_relative 'component'
require_relative 'service_locator'

class PlayerSpriteComponent < Component
  
  attr_reader :sprite, :direction
  def initialize(owner, sprite)
    super(owner)
    @sprite = sprite
    @direction = :down
  end

  def receive(sender, message)
    if message.type == :object_position && message.data[:id] == @owner.id

      @sprite.x = message.data[:vector][0] 
      @sprite.y = message.data[:vector][1]

      if message.data[:direction] == :up && @direction != :up
          ng = NumberGraph.new
          ng.define(0,1)
          @sprite.animation_graph(ServiceLocator.image_manager.get("player_walk_up.png"), ng)
      elsif message.data[:direction] == :down && direction != :down
          ng = NumberGraph.new
          ng.define(0,1)
          @sprite.animation_graph(ServiceLocator.image_manager.get("player_walk_down.png"), ng)
      elsif message.data[:direction] == :right && direction != :right
          ng = NumberGraph.new
          ng.define(0,1)
          @sprite.animation_graph(ServiceLocator.image_manager.get("player_walk_right.png"), ng)
      elsif message.data[:direction] == :left && direction != :left
          ng = NumberGraph.new
          ng.define(0,1)
          @sprite.animation_graph(ServiceLocator.image_manager.get("player_walk_left.png"), ng)
      end

      if message.data[:velocity][0] == 0 && message.data[:velocity][1] == 0
        @sprite.number_graph.goto(0)
        @sprite.speed = -1
      else
        @sprite.speed = 10 
      end

      @direction = message.data[:direction]
    end
  end

end
