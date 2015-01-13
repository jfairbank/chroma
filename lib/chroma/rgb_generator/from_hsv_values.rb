module Chroma
  module RgbGenerator
    class FromHsvValues < Base
      # @param format [Symbol]          color format
      # @param h      [String, Numeric] hue value
      # @param s      [String, Numeric] saturation value
      # @param v      [String, Numeric] value value
      # @param a      [String, Numeric] alpha value
      def initialize(format, h, s, v, a = 1)
        s = to_percentage(s)
        v = to_percentage(v)

        @format = format || :hsv
        @hsv = ColorModes::Hsv.new(h, s, v, a)
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        [Converters::RgbConverter.convert_hsv(@hsv), @format]
      end
    end
  end
end
