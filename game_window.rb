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
require_relative 'renderer'
require_relative 'camera_filter'
require_relative 'smooth_move_camera_filter'
require_relative 'follow_camera_filter'
require_relative 'z_layer_filter'
require_relative 'smooth_follow_filter'

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


    #load up sprties
    sprite = Gosu::Image.new(self, "player.png", false)

    #create first player component
    player = GameObject.new(1)
    move_comp = MovementComponent.new(player, 50, 50, 0)
    player.add(move_comp)
    player_body = PhysicsBody.new(player.id, 50,50,23,23)
    player_sprite = Sprite.new(player.id, sprite, 50, 50, 0)
    @physics_manager.add(player_body)
    @object_manager.add(player)
    @sprite_manager.add(player_sprite)

    #create second player components
    player2 = GameObject.new(2)
    move_comp2 = MovementComponent.new(player2, 100, 150)
    player2.add(move_comp2)
    player2_body = PhysicsBody.new(player2.id, 100, 150, 23, 23)
    player2_sprite = Sprite.new(player2.id, sprite, 100, 50, 0)
    @object_manager.add(player2)
    @physics_manager.add(player2_body)
    @sprite_manager.add(player2_sprite)

    #create blocks
    brick_image = Gosu::Image.new(self, "block.png", false)

    20.times do |x|
      block_sprite = Sprite.new(x+3, brick_image, x*23, 0)
      block_body = PhysicsBody.new(x+3,x*23,0, 23, 23)
      @physics_manager.add(block_body)
      @sprite_manager.add(block_sprite)
    end

    EventBus.register(player, :keyboard, :physics_manager)
    EventBus.register(player2, :physics_manager)
    EventBus.register(player_body, :object_position)
    EventBus.register(player2_body, :object_position)
    EventBus.register(player_sprite, :object_position)
    EventBus.register(player2_sprite, :object_position)

  end
  
  def update
    @object_manager.update
    @physics_manager.update
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
