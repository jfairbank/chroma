module Chroma
  module RgbGenerator
    class FromHslValues < Base
      def initialize(format, h, s, l, a = 1)
        s = to_percentage(s)
        l = to_percentage(l)

        @format = format || :hsl
        @hsl = ColorModes::Hsl.new(h, s, l, a)
      end

      def generate
        [Converters::RgbConverter.convert_hsl(@hsl), @format]
      end
    end
  end
end
