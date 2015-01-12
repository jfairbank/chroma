module Chroma
  module RgbGenerator
    class FromHsl < Base
      def initialize(format, hsl)
        @format = format
        @hsl = hsl
      end

      def generate
        FromHslValues.new(@format, *@hsl.to_a).generate
      end
    end
  end
end
