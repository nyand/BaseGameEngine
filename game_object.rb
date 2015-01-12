require_relative 'local_event_bus'
class GameObject

  attr_reader :id, :bus
  def initialize(id)
    @id = id
    @bus = LocalEventBus.new
    @bus.register(self)
    @components = []
  end

  def add(component)
    @components << component
  end

  def remove(component)
    @components.delete(component)
  end

  def draw
  end

  def update
    @components.each { |component| component.update }
  end

  def receive(sender, message)
    if sender == EventBus && message.data[:id] != @id && message.data[:object_relay] != true
      message.data[:object_relay] = true
      @bus.push(message.type, message.data)
    elsif sender == @bus && message.data[:object_relay] != true
      EventBus.push(message.type, message.data)
    end
  end

end
