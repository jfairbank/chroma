module Chroma
  module RgbGenerator
    class FromHsvValues < Base
      def initialize(format, h, s, v, a = 1)
        s = to_percentage(s)
        v = to_percentage(v)

        @format = format
        @hsv = ColorModes::Hsv.new(h, s, v, a)
      end

      def generate
        FromHsv.new(@format, @hsv).generate
      end
    end
  end
end
