module Chroma
  module RgbGenerator
    class FromRgb < Base
      def initialize(format, rgb)
        @format = format || :rgb
        @rgb = rgb
      end

      def generate
        FromRgbValues.new(@format, @rgb.r, @rgb.g, @rgb.b, @rgb.a).generate
      end
    end
  end
end
