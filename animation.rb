require_relative 'sprite'
require_relative 'number_graph'

class Animation < Sprite

  attr_accessor :repeat, :speed
  attr_reader :animation, :number_graph
  def initialize(id, animation, number_graph, speed = 30, repeat = 0, x = 0, y = 0, z = 0, visible = true, scale_x = 1, scale_y = 1, rot = 0)
    super(id, animation[number_graph.current], x, y, z, visible, scale_x, scale_y, rot)
    @animation = animation
    @number_graph = number_graph
    @speed = speed
    @count = 0
  end

  def update
    @count = (@count + 1) % speed if @speed > -1
    self.sprite = @animation[@number_graph.next!] if @count == 0
  end

  def animation_graph(animation, number_graph)
    @animation = animation
    self.sprite = animation[number_graph.current]
    @count = 0
  end

  def number_graph=(number_graph)
    @number_graph = number_graph
    @count = 0
    self.sprite = @animation[number_graph.current]
  end
end
