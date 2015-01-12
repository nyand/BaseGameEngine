class NumberGraph

  def initialize
    @graph = []
    @index = -1
    @previous = -1
  end


  def goto(number)
    @previous = @index
    @index = number % @graph.count
    @graph[@index]
  end

  def next!
    raise 'NumberGraph undefined' if @index == -1

    if @graph[@index].class == NumberGraphEnd 
      false
    else
      @previous = @index
      @index = (@index + 1) % @graph.count
      @graph[@index]
    end
  end

  def next
    raise 'NumberGraph undefined' if @index == -1

    if @graph[@index].class == NumberGraphEnd
      false
    else
      next_index = (@index + 1) % @graph.count
      @graph[next_index]
    end
  end

  def current
    raise 'NumberGraph undefined' if @index == -1

    @graph[@index]
  end

  def previous
    raise 'NumberGraph undefined' if @index == -1

    if @previous == -1
      false
    else
      @graph[@previous]
    end
  end

  def clear
    @graph = []
    @index = @previous = -1
  end

  def define(*numbers)
    if numbers.count > 0
      @graph = numbers
      @index = 0
      @previous = -1
    end
  end
end
