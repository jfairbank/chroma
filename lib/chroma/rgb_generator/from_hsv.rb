module Chroma
  module RgbGenerator
    class FromHsv < Base
      # @param format [Symbol] color format
      # @param hsv    [ColorModes::Hsv]
      def initialize(format, hsv)
        @format = format
        @hsv = hsv
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        FromHsvValues.new(@format, *@hsv.to_a).generate
      end
    end
  end
end
