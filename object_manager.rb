class ObjectManager

  def initialize
    @objects = {}
    @id = 0
  end

  def add(object)
    @objects[@id] = object
    @id += 1
  end

  def remove(object)
    @objects.select { |id,object| object == object}.each_key { |key| @objects[key] = nil } 
  end

  def update
    @objects.each_value { |object| object.update }
  end

  def receive(sender, message)
  end
end
