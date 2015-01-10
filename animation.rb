require_relative 'sprite'
require_relative 'number_graph'

class Animation < Sprite

  attr_accessor :animation, :repeat, :number_graph, :speed
  def initialize(id, animation, number_graph, speed = 30, repeat = 0, x = 0, y = 0, z = 0, scale_x = 1, scale_y = 1, rot = 0)
    super(id, animation[number_graph.current], x, y, z, scale_x, scale_y, rot)
    @animation = animation
    @number_graph = number_graph
    @speed = speed
    @count = 0
  end

  def update
    @count = (@count + 1) % speed
    self.sprite = @animation[@number_graph.next!] if @count == 0
  end

end
