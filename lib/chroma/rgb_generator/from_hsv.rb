module Chroma
  module RgbGenerator
    class FromHsv < Base
      def initialize(format, hsv)
        @format = format || :hsv
        @hsv = hsv
      end

      def generate
        [Converters::RgbConverter.convert_hsv(@hsv), @format]
      end
    end
  end
end
