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

  def notify(sender, message)
    @subscribers.each { |sub| sub.receive(sender, message) }
  end
end
