require_relative 'event_bus'
class PhysicsManager

  def initialize
    @bodies = []
  end

  def add(body)
    @bodies << body
  end

  def remove(body)
    @bodies.remove(body)
  end

  def receive_message(sender, message)

  end

  def update
    @bodies.each do |body1|
      @bodies.each do |body2|
        if body1.bitmask & body2.bitmask != 0
          if !body1.equal?(body2) && aabb_collision?(body1, body2)
            message = {id: PhysicsManager.class, event: "collision", object1: body1.id, object2: body2.id}
            EventBus.push(:physics_manager, message)
          end
        end
      end
    end
  end

  def aabb_collision?(object1, object2)
    !((object1.x + object1.width) < object2.x || object1.x > (object2.x + object2.width) || object1.y > (object2.y + object2.height) || (object1.y + object1.height) < object2.y)
  end
end
