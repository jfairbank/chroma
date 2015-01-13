module Chroma
  module RgbGenerator
    class FromHslValues < Base
      # @param format [Symbol]          color format
      # @param h      [String, Numeric] hue value
      # @param s      [String, Numeric] saturation value
      # @param l      [String, Numeric] lightness value
      # @param a      [String, Numeric] alpha value
      def initialize(format, h, s, l, a = 1)
        s = to_percentage(s)
        l = to_percentage(l)

        @format = format || :hsl
        @hsl = ColorModes::Hsl.new(h, s, l, a)
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        [Converters::RgbConverter.convert_hsl(@hsl), @format]
      end
    end
  end
end
