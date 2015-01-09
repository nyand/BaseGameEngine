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
    if sender == EventBus && message.data[:id] != @id
      @bus.push(message.type, message.data)
    elsif sender == @bus
      EventBus.push(sender, message.data)
    end
  end

end
