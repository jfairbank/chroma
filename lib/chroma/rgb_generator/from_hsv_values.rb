module Chroma
  module RgbGenerator
    class FromHsvValues < Base
      def initialize(format, h, s, v, a = 1)
        s = to_percentage(s)
        v = to_percentage(v)

        @format = format || :hsv
        @hsv = ColorModes::Hsv.new(h, s, v, a)
      end

      def generate
        [Converters::RgbConverter.convert_hsv(@hsv), @format]
      end
    end
  end
end
