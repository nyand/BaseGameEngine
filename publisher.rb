class Publisher

  def initialize
    @subscribers = []
  end

  def sub(subscriber)
    @subscribers << subscriber
  end

  def unsub(subscriber)
    @subscribers.delete(subscriber)
  end

  def notify(message)
    @subscribers.each { |sub| sub.receive(self, message) }
  end
end
