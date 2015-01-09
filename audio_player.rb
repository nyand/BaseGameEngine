class AudioPlayer

  def initialize

  end
  
  def play(song, looped = false)
    song.play(looped)
  end

  def receive_message(sender, message)
    #code to handle play requests
  end
end
