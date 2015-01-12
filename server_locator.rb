class ServiceLocator
    @@image_manager = nil
    @@global_event_bus = EventBus 

  def self.image_manager
    @@image_manager 
  end

  def self.image_manager=(service)
    @@image_manager = service
  end

  def self.global_event_bus
    @@global_event_bus
  end

  def self.global_event_bus=(service)
    @@global_event_bus = service
  end
end
