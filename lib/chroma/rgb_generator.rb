module Chroma
  module RgbGenerator
    class << self
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
