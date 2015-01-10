module Chroma
  module Converters
    class Base
      include Helpers::Bounders

      def initialize(input)
        @input = input
      end

      def self.convert_rgb(rgb)
        new(rgb).convert_rgb
      end

      def self.convert_hsl(hsl)
        new(hsl).convert_hsl
      end

      def self.convert_hsv(hsv)
        new(hsv).convert_hsv
      end
    end
  end
end
