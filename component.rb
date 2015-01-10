class Component

  attr_reader :bus

  def initialize(owner)
    @owner = owner
    @bus = owner.bus
    @bus.register(self)
  end

  def update
  end

  def receive(sender, message)
    #do something with the message
  end
  
end
