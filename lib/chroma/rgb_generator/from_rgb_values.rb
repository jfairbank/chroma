module Chroma
  module RgbGenerator
    class FromRgbValues < Base
      def initialize(format, r, g, b, a = 1)
        @format = format
        @r, @g, @b, @a = r, g, b, a
      end

      def generate
        r, g, b = [@r, @g, @b].map { |n| bound01(n, 255) * 255 }
        a = bound_alpha(@a)
        [ColorModes::Rgb.new(r, g, b, a), @format]
      end
    end
  end
end
