module Chroma
  module Converters
    # Base class for converting one color mode to another.
    # @abstract
    class Base
      include Helpers::Bounders

      # @param input [ColorModes::Rgb, ColorModes::Hsl, ColorModes::Hsv]
      # @return [Base]
      def initialize(input)
        @input = input
      end

      # @param rgb [ColorModes::Rgb]
      # @return [ColorModes::Rgb, ColorModes::Hsl, ColorModes::Hsv]
      def self.convert_rgb(rgb)
        new(rgb).convert_rgb
      end

      # @param hsl [ColorModes::Hsl]
      # @return [ColorModes::Rgb, ColorModes::Hsl, ColorModes::Hsv]
      def self.convert_hsl(hsl)
        new(hsl).convert_hsl
      end

      # @param hsv [ColorModes::Hsv]
      # @return [ColorModes::Rgb, ColorModes::Hsl, ColorModes::Hsv]
      def self.convert_hsv(hsv)
        new(hsv).convert_hsv
      end
    end
  end
end
