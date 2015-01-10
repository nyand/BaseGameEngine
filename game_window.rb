require 'gosu'
require_relative 'player'
require_relative 'object_manager'
require_relative 'movement_component'
require_relative 'keyboard_publisher'
require_relative 'event_bus'
require_relative 'message'
require_relative 'physics_manager'
require_relative 'physics_body'
require_relative 'sprite_manager'
require_relative 'sprite'
require_relative 'sprite_component'
require_relative 'renderer'
require_relative 'camera_filter'
require_relative 'smooth_move_camera_filter'
require_relative 'follow_camera_filter'
require_relative 'z_layer_filter'
require_relative 'smooth_follow_filter'
require_relative 'animation'
require_relative 'number_graph'
require_relative 'number_graph_end'

class GameWindow < Gosu::Window

  def initialize
    super 640, 480, false
    @object_manager = ObjectManager.new
    @keyboard_publisher = KeyboardPublisher.new

    @physics_manager = PhysicsManager.new
    @sprite_manager = SpriteManager.new

    #create render and camera filters
    @renderer = Renderer.new(self)
    #@filter = FollowCameraFilter.new(480, 360, 1, -80,0)
    @filter = SmoothMoveCameraFilter.new(320, 240, 640, 480, 50, 50, 2, 2)
    @z_filter = ZLayerFilter.new
    @smooth_follow = SmoothFollowFilter.new(1)


    #load up sprite animations
    anim = Gosu::Image.load_tiles(self, "player_walk_down.png", -2, -1, false)
    

    #create first player component
    player = GameObject.new(1)
    move_comp = MovementComponent.new(player, 100, 100, 0)
    player.add(move_comp)
    player_body = PhysicsBody.new(player.id, 100,100,23,23)
    player_anim_ng = NumberGraph.new
    player_anim_ng.define(0,1)
    player_anim = Animation.new(player.id, anim, player_anim_ng, 10)
    player_sprite_component = SpriteComponent.new(player, player_anim)
    player.add(player_sprite_component)
    @physics_manager.add(player_body)
    @object_manager.add(player)
    @sprite_manager.add(player_anim)

    #create second player components
    player2 = GameObject.new(2)
    move_comp2 = MovementComponent.new(player2, 100, 150)
    player2.add(move_comp2)
    player2_body = PhysicsBody.new(player2.id, 100, 150, 23, 23)
    player2_sprite = Sprite.new(player2.id, anim[1], 100, 50, 0)
    player2_sprite_component = SpriteComponent.new(player2, player2_sprite)
    player2.add(player2_sprite_component)
    @object_manager.add(player2)
    @physics_manager.add(player2_body)
    @sprite_manager.add(player2_sprite)

    #create blocks
    brick_image = Gosu::Image.new(self, "block.png", false)

    20.times do |x|
      block_object = GameObject.new(x+3)
      block_sprite = Sprite.new(block_object.id, brick_image, x*23, 0)
      block_sprite_comp = SpriteComponent.new(block_object, block_sprite)
      block_object.add(block_sprite_comp)
      block_body = PhysicsBody.new(x+3,x*23,0, 22, 23)
      @physics_manager.add(block_body)
      @sprite_manager.add(block_sprite)
      @object_manager.add(block_object)
    end

    EventBus.register(player, :keyboard, :physics_manager)
    EventBus.register(player2, :physics_manager)
    EventBus.register(player_body, :object_position)
    EventBus.register(player2_body, :object_position)

  end
  
  def update
    @object_manager.update
    @physics_manager.update
    @sprite_manager.update
  end

  def draw
    @smooth_follow.track(@sprite_manager.sprites, @filter)
    @renderer.draw(@z_filter.filter(@filter.filter(@sprite_manager.sprites)))
  end

  def button_down(id)
    @keyboard_publisher.button_down(id)
  end

  def button_up(id)
    @keyboard_publisher.button_up(id)
  end

end

game = GameWindow.new
game.show
