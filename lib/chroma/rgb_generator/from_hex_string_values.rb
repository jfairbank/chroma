module Chroma
  module RgbGenerator
    class FromHexStringValues < Base
      # @param format [Symbol] color format
      # @param r      [String] red value
      # @param g      [String] green value
      # @param b      [String] blue value
      # @param a      [String] alpha value
      def initialize(format, r, g, b, a = 'ff')
        @format = format || :hex
        @r, @g, @b, @a = r, g, b, a
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        r, g, b = [@r, @g, @b].map { |n| n.to_i(16) }
        a = @a.to_i(16) / 255.0
        [ColorModes::Rgb.new(r, g, b, a), @format]
      end

      class << self
        # Generates a {ColorModes::Rgb} from 3-character hexadecimal.
        # @return [ColorModes::Rgb]
        #
        # @param format [Symbol] color format
        # @param r      [String] red value
        # @param g      [String] green value
        # @param b      [String] blue value
        def from_hex3(format, r, g, b)
          new(format || :hex3, r * 2, g * 2, b * 2)
        end

        # Generates a {ColorModes::Rgb} from 6-character hexadecimal.
        # @return [ColorModes::Rgb]
        #
        # @param format [Symbol] color format
        # @param r      [String] red value
        # @param g      [String] green value
        # @param b      [String] blue value
        def from_hex6(format, r, g, b)
          new(format, r, g, b)
        end

        # Generates a {ColorModes::Rgb} from 8-character hexadecimal.
        # @return [ColorModes::Rgb]
        #
        # @param format [Symbol] color format
        # @param r      [String] red value
        # @param g      [String] green value
        # @param b      [String] blue value
        # @param a      [String] alpha value
        def from_hex8(format, r, g, b, a)
          new(format || :hex8, r, g, b, a)
        end
      end
    end
  end
end
