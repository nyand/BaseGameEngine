class Component

  attr_reader :bus

  def initialize(owner)
    @owner = owner
    @bus = owner.bus
  end

  def update
  end

  def receive(message)
    #do something with the message
  end
  
end
