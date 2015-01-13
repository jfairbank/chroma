class String
  # Creates {Chroma::Color} directly from a string representing a color.
  #
  # @example
  #   'red'.paint
  #   '#f00'.paint
  #   '#ff0000'.paint
  #   'rgb(255, 0, 0)'.paint
  #   'hsl(0, 100%, 50%)'.paint
  #   'hsv(0, 100%, 100%)'.paint
  #
  # @return [Chroma::Color]
  def paint
    Chroma.paint(self)
  end
end
