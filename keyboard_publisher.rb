require_relative 'publisher'
require_relative 'event_bus'
class KeyboardPublisher

  def initialize
    @event_code = :keyboard
  end

  def button_down(id)
    message = {type: :down, button: id}
    EventBus.push(@event_code, message)
  end
  
  def button_up(id)
    message = {type: :up, button: id}
    EventBus.push(@event_code, message)
  end
end
