module Chroma
  module RgbGenerator
    class FromHsl < Base
      def initialize(format, hsl)
        @format = format || :hsl
        @hsl = hsl
      end

      def generate
        [Converters::RgbConverter.convert_hsl(@hsl), @format]
      end
    end
  end
end
