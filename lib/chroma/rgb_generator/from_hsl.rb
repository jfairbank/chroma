module Chroma
  module RgbGenerator
    class FromHsl < Base
      # @param format [Symbol] color format
      # @param hsl    [ColorModes::Hsl]
      def initialize(format, hsl)
        @format = format
        @hsl = hsl
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        FromHslValues.new(@format, *@hsl.to_a).generate
      end
    end
  end
end
