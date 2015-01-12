class VisibleFilter

  def filter(sprites)
    sprites.select { |sprite| sprite.visible }
  end
end
