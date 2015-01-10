module Chroma
  module Converters
    class HslConverter < Base
      def convert_rgb
        r = bound01(@input.r, 255)
        g = bound01(@input.g, 255)
        b = bound01(@input.b, 255)

        rgb_array = [r, g, b]

        max = rgb_array.max
        min = rgb_array.min
        l = (max + min) * 0.5

        if max == min
          h = s = 0
        else
          d = (max - min).to_f

          s = if l > 0.5
                d / (2 - max - min)
              else
                d / (max + min)
              end

          h = case max
              when r then (g - b) / d + (g < b ? 6 : 0)
              when g then (b - r) / d + 2
              when b then (r - g) / d + 4
              end

          h /= 6.0
        end

        ColorModes::Hsl.new(h * 360, s, l, @input.a)
      end
    end
  end
end
