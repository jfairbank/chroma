module Chroma
  class Color
    module Modifiers
      def lighten(amount = 10)
        hsl = self.hsl
        hsl.l = clamp01(hsl.l + amount / 100.0)
        self.class.new(hsl, @format)
      end

      def brighten(amount = 10)
        # Don't include alpha
        rgb = @rgb.to_a[0..2].map(&:round)
        amount = (255 * (-amount / 100.0)).round

        rgb.map! do |n|
          [0, [255, n - amount].min].max
        end

        self.class.new(ColorModes::Rgb.new(*rgb), @format)
      end

      def darken(amount = 10)
        hsl = self.hsl
        hsl.l = clamp01(hsl.l - amount / 100.0)
        self.class.new(hsl, @format)
      end

      def desaturate(amount = 10)
        hsl = self.hsl
        hsl.s = clamp01(hsl.s - amount / 100.0)
        self.class.new(hsl, @format)
      end

      def saturate(amount = 10)
        hsl = self.hsl
        hsl.s = clamp01(hsl.s + amount / 100.0)
        self.class.new(hsl, @format)
      end

      def greyscale
        desaturate(100)
      end

      def spin(amount)
        hsl = self.hsl
        hue = (hsl.h.round + amount) % 360
        hsl.h = hue < 0 ? 360 + hue : hue
        self.class.new(hsl, @format)
      end
    end
  end
end
