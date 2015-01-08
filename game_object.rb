class GameObject

  attr_reader :id
  def initialize(id)
    @id = id
  end

  def draw
  end

  def update
  end

  def receive(sender, message)
  end
end
