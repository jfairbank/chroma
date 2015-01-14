module Chroma
  module RgbGenerator
    class FromRgbValues < Base
      # @param format [Symbol]          color format
      # @param r      [String, Numeric] red value
      # @param g      [String, Numeric] green value
      # @param b      [String, Numeric] blue value
      # @param a      [String, Numeric] alpha value
      def initialize(format, r, g, b, a = 1)
        @format = format || :rgb
        @r, @g, @b, @a = r, g, b, a
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        r, g, b = [@r, @g, @b].map { |n| bound01(n, 255) * 255 }
        a = bound_alpha(@a)
        [ColorModes::Rgb.new(r, g, b, a), @format]
      end
    end
  end
end
