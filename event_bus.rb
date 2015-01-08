require_relative 'publisher'
require_relative 'message'
class EventBus
  @@publisher = {all: Publisher.new} 

  def self.register(object, *filters)
    if filters.count == 0
      @@publisher[:all].sub(object) 
      @@publisher.reject { |filter, publisher| filter == :all }.each_value do |pub|
        pub.unsub(object)
      end
    else
      @@publisher[:all].unsub(object)
      filters.each do |filter|
        @@publisher[filter] = Publisher.new unless @@publisher[filter]
        @@publisher[filter].sub(object)
      end
    end
  end

  def self.unregister(object, *filters)
    if filters.count == 0
      @@publisher.each_value { |publisher| publisher.unsub(object) }
    else
      filters.each do |filter|
        @@publisher[filter].unsub(object) if @@publisher[filter]
      end
    end
  end

  def self.push(type, data)
    message = Message.new(type, data)
    @@publisher[:all].notify(message)

    @@publisher.select { |filter,publisher| filter == type }.each_value do |pub|
      pub.notify(message)
    end
  end
end
