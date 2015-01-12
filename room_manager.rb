class RoomManager

  attr_reader :current
  def initialize(init_room)
    @rooms = {}
    @id = 0
    add(room)
    @current = room
  end

  def add(room)
    @rooms[@id] = room
    room.id = @id

    @id += 1
  end

  def remove(room)
    @rooms.delete_if { |id, r| r == room }
  end

end
