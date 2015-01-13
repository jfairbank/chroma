module Chroma
  # Main module to generate an instance of {ColorModes::Rgb} from several
  # possible inputs.
  module RgbGenerator
    class << self
      # Generates an instance of {ColorModes::Rgb} as well as color format
      #   symbol.
      #
      # @param input [String, ColorModes::Rgb, ColorModes::Hsl, ColorModes::Hsv]
      # @return      [[ColorModes::Rgb, Symbol]]
      def generate_rgb_and_format(input)
        get_generator(input).generate.tap do |(rgb)|
          rgb.r = round(rgb.r)
          rgb.g = round(rgb.g)
          rgb.b = round(rgb.b)
        end
      end

      private

      def get_generator(input)
        klass = case input
                when String          then FromString
                when ColorModes::Hsl then FromHsl
                when ColorModes::Hsv then FromHsv
                when ColorModes::Rgb then FromRgb
                end

        klass.new(nil, input)
      end

      def round(n)
        n < 1 ? n.round : n
      end
    end
  end
end
