module Chroma
  class Color
    # Methods that return a new modified {Color}.
    module Modifiers
      # Lightens the color by the given `amount`.
      #
      # @example
      #   'red'.paint.lighten     #=> #ff3333
      #   'red'.paint.lighten(20) #=> #ff6666
      #
      # @param amount [Fixnum]
      # @return       [Color]
      def lighten(amount = 10)
        hsl = self.hsl
        hsl.l = clamp01(hsl.l + amount / 100.0)
        self.class.new(hsl, @format)
      end

      # Brightens the color by the given `amount`.
      #
      # @example
      #   'red'.paint.brighten     #=> #ff1a1a
      #   'red'.paint.brighten(20) #=> #ff3333
      #
      # @param amount [Fixnum]
      # @return       [Color]
      def brighten(amount = 10)
        # Don't include alpha
        rgb = @rgb.to_a[0..2]
        amount = (255 * (-amount / 100.0)).round

        rgb.map! do |n|
          [0, [255, n - amount].min].max
        end

        self.class.new(ColorModes::Rgb.new(*rgb), @format)
      end

      # Darkens the color by the given `amount`.
      #
      # @example
      #   'red'.paint.darken     #=> #cc0000
      #   'red'.paint.darken(20) #=> #990000
      #
      # @param amount [Fixnum]
      # @return       [Color]
      def darken(amount = 10)
        hsl = self.hsl
        hsl.l = clamp01(hsl.l - amount / 100.0)
        self.class.new(hsl, @format)
      end

      # Desaturates the color by the given `amount`.
      #
      # @example
      #   'red'.paint.desaturate     #=> #f20d0d
      #   'red'.paint.desaturate(20) #=> #e61919
      #
      # @param amount [Fixnum]
      # @return       [Color]
      def desaturate(amount = 10)
        hsl = self.hsl
        hsl.s = clamp01(hsl.s - amount / 100.0)
        self.class.new(hsl, @format)
      end

      # Saturates the color by the given `amount`.
      #
      # @example
      #   '#123'.paint.saturate     #=> #0e2236
      #   '#123'.paint.saturate(20) #=> #0a223a
      #
      # @param amount [Fixnum]
      # @return       [Color]
      def saturate(amount = 10)
        hsl = self.hsl
        hsl.s = clamp01(hsl.s + amount / 100.0)
        self.class.new(hsl, @format)
      end

      # Converts the color to grayscale.
      #
      # @example
      #   'green'.paint.grayscale #=> #404040
      #
      # @return [Color]
      def grayscale
        desaturate(100)
      end

      alias_method :greyscale, :grayscale

      # Sets color opacity to the given 'amount'.
      #
      # @example
      #   'red'.paint.opacity(0.5)        #=> #ff0000
      #   'red'.paint.opacity(0.5).to_rgb #=> 'rgba(255, 0, 0, 0.5)'
      #
      # @param amount [Fixnum]
      # @return       [Color]
      def opacity(amount)
        rgb = @rgb.to_a[0..2] + [amount]
        self.class.new(ColorModes::Rgb.new(*rgb), @format)
      end

      # Spins around the hue color wheel by `amount` in degrees.
      #
      # @example
      #   'red'.paint.spin(30) #=> #ff8000
      #   'red'.paint.spin(60) #=> yellow
      #   'red'.paint.spin(90) #=> #80ff00
      #
      # @param amount [Fixnum]
      # @return       [Color]
      def spin(amount)
        hsl = self.hsl
        hue = (hsl.h.round + amount) % 360
        hsl.h = hue < 0 ? 360 + hue : hue
        self.class.new(hsl, @format)
      end
    end
  end
end
