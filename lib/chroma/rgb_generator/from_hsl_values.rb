module Chroma
  module RgbGenerator
    class FromHslValues < Base
      def initialize(format, h, s, l, a = 1)
        s = to_percentage(s)
        l = to_percentage(l)

        @format = format
        @hsl = ColorModes::Hsl.new(h, s, l, a)
      end

      def generate
        FromHsl.new(@format, @hsl).generate
      end
    end
  end
end
