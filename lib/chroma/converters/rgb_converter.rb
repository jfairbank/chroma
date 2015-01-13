module Chroma
  module Converters
    # Class to convert a color mode to {ColorModes::Rgb}.
    class RgbConverter < Base
      # Returns @input because it's the same color mode.
      # @return [ColorModes::Rgb]
      def convert_rgb
        @input
      end

      # Convert hsl to rgb.
      # @return [ColorModes::Rgb]
      def convert_hsl
        h, s, l = @input

        h = bound01(h, 360)
        s = bound01(s, 100)
        l = bound01(l, 100)

        if s.zero?
          r = g = b = l * 255
        else
          q = l < 0.5 ? l * (1 + s) : l + s - l * s
          p = 2 * l - q
          r = hue_to_rgb(p, q, h + 1/3.0) * 255
          g = hue_to_rgb(p, q, h) * 255
          b = hue_to_rgb(p, q, h - 1/3.0) * 255
        end

        ColorModes::Rgb.new(r, g, b, bound_alpha(@input.a))
      end

      # Convert hsv to rgb.
      # @return [ColorModes::Rgb]
      def convert_hsv
        h, s, v = @input

        h = bound01(h, 360) * 6
        s = bound01(s, 100)
        v = bound01(v, 100)

        i = h.floor
        f = h - i
        p = v * (1 - s)
        q = v * (1 - f * s)
        t = v * (1 - (1 - f) * s)
        mod = i % 6

        r = [v, q, p, p, t, v][mod] * 255
        g = [t, v, v, q, p, p][mod] * 255
        b = [p, p, t, v, v, q][mod] * 255

        ColorModes::Rgb.new(r, g, b, bound_alpha(@input.a))
      end

      private

      def hue_to_rgb(p, q, t)
        if t < 0    then t += 1
        elsif t > 1 then t -= 1
        end

        if    t < 1/6.0 then p + (q - p) * 6 * t
        elsif t < 0.5   then q
        elsif t < 2/3.0 then p + (q - p) * (2/3.0 - t) * 6
        else                 p
        end
      end
    end
  end
end
