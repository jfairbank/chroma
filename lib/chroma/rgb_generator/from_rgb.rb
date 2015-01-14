module Chroma
  module RgbGenerator
    class FromRgb < Base
      # @param format [Symbol] color format
      # @param rgb    [ColorModes::Rgb]
      def initialize(format, rgb)
        @format = format
        @rgb = rgb
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        FromRgbValues.new(@format, @rgb.r, @rgb.g, @rgb.b, @rgb.a).generate
      end
    end
  end
end
