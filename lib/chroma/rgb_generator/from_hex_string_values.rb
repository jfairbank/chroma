module Chroma
  module RgbGenerator
    class FromHexStringValues < Base
      def initialize(format, r, g, b, a = 'ff')
        @format = format || :hex
        @r, @g, @b, @a = r, g, b, a
      end

      def generate
        r, g, b = [@r, @g, @b].map { |n| n.to_i(16) }
        a = @a.to_i(16) / 255.0
        [ColorModes::Rgb.new(r, g, b, a), @format]
      end

      class << self
        def from_hex3(format, r, g, b)
          new(format || :hex3, r * 2, g * 2, b * 2)
        end

        def from_hex6(format, r, g, b)
          new(format, r, g, b)
        end

        def from_hex8(format, r, g, b, a)
          new(format || :hex8, r, g, b, a)
        end
      end
    end
  end
end
