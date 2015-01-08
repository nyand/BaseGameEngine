require 'gosu'
require_relative 'player'
require_relative 'object_manager'
require_relative 'keyboard_publisher'
require_relative 'event_bus'
require_relative 'message'
require_relative 'physics_manager'
require_relative 'physics_body'
require_relative 'sprite_manager'
require_relative 'sprite'
require_relative 'renderer'
require_relative 'camera_filter'
require_relative 'follow_camera_filter'

class GameWindow < Gosu::Window

  def initialize
    super 480, 360, false
    @object_manager = ObjectManager.new
    @keyboard_publisher = KeyboardPublisher.new

    @physics_manager = PhysicsManager.new
    @sprite_manager = SpriteManager.new
    @renderer = Renderer.new(self)
    @filter = FollowCameraFilter.new(480, 360, 1, -80,0)

    player = Player.new(1, 50, 50)
    player_body = PhysicsBody.new(1, 50,50,23,23)
    @sprite = Gosu::Image.new(self, "player.png", false)
    spritesheet = Gosu::Image.new(self, "spritesheet.png", false)
    puts "failed" unless @sprite
    player_sprite = Sprite.new(1, spritesheet, 50, 50, 0)

    player2 = Player.new(2, 100, 150)
    player2_body = PhysicsBody.new(2, 100, 150, 23, 23)
    player2_sprite = Sprite.new(2, @sprite, 100, 50, 0)
    @object_manager.add(player2)
    @physics_manager.add(player2_body)
    @sprite_manager.add(player2_sprite)

    @physics_manager.add(player_body)
    @object_manager.add(player)
    @sprite_manager.add(player_sprite)

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
    @renderer.draw(@filter.filter(@sprite_manager.sprites))
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
