module Chroma
  class Color
    # Methods for serializing {Color} to different color mode string formats.
    module Serializers
      # Convert to hsv string.
      #
      # @example
      #   'red'.paint.to_hsv                  #=> 'hsv(0, 100%, 100%)'
      #   'rgba(255, 0, 0, 0.5)'.paint.to_hsv #=> 'hsva(0, 100%, 100%, 0.5)'
      #
      # @return [String]
      def to_hsv
        to_hs(:v)
      end

      # Convert to hsl string.
      #
      # @example
      #   'red'.paint.to_hsl                  #=> 'hsl(0, 100%, 50%)'
      #   'rgba(255, 0, 0, 0.5)'.paint.to_hsl #=> 'hsla(0, 100%, 50%, 0.5)'
      #
      # @return [String]
      def to_hsl
        to_hs(:l)
      end

      # Convert to hexadecimal string.
      #
      # @example
      #   'red'.paint.to_hex                  #=> '#ff0000'
      #   'red'.paint.to_hex(true)            #=> '#f00'
      #   'rgba(255, 0, 0, 0.5)'.paint.to_hex #=> '#ff0000'
      #
      # @param allow_3 [true, false] output 3-character hexadecimal
      #   if possible
      # @return [String]
      def to_hex(allow_3 = false)
        "##{to_basic_hex(allow_3)}"
      end

      # Convert to 8-character hexadecimal string. The highest order byte
      #   (left most hexadecimal pair represents the alpha value).
      #
      # @example
      #   'red'.paint.to_hex                  #=> '#ffff0000'
      #   'rgba(255, 0, 0, 0.5)'.paint.to_hex #=> '#80ff0000'
      #
      # @return [String]
      def to_hex8
        "##{to_basic_hex8}"
      end

      # Convert to rgb string.
      #
      # @example
      #   'red'.paint.to_rgb                  #=> 'rgb(255, 0, 0)'
      #   'rgba(255, 0, 0, 0.5)'.paint.to_rgb #=> 'rgb(255, 0, 0, 0.5)'
      #
      # @return [String]
      def to_rgb
        middle = @rgb.to_a[0..2].map(&:round).join(', ')

        with_alpha(:rgb, middle)
      end

      # Convert to named color if possible. If a color name can't be found, it
      # returns `'<unknown>'` or the hexadecimal string based on the value of
      # `hex_for_unknown`.
      #
      # @example
      #   'red'.paint.to_name                  #=> 'red'
      #   'rgba(255, 0, 0, 0.5)'.paint.to_name #=> '<unknown>'
      #   '#00f'.paint.to_name                 #=> 'blue'
      #   '#123'.paint.to_name(true)           #=> '#112233'
      #
      # @param hex_for_unknown [true, false] determine how unknown color names
      #   should be returned
      # @return [String]
      def to_name(hex_for_unknown = false)
        return 'transparent' if alpha.zero?

        if alpha < 1 || (name = Chroma.name_from_hex(to_basic_hex(true))).nil?
          if hex_for_unknown
            to_hex
          else
            '<unknown>'
          end
        else
          name
        end
      end

      # Convert to a string based on the color format.
      #
      # @example
      #   'red'.paint.to_s             #=> 'red'
      #   'rgb(255, 0, 0)'.paint.to_s  #=> 'rgb(255, 0, 0)'
      #   '#f00'.paint.to_s            #=> '#f00'
      #   '#80ff0000'.paint.to_s(:rgb) #=> 'rgba(255, 0, 0, 0.5)'
      #
      # @param format [Symbol] the color format
      # @return       [String]
      def to_s(format = @format)
        use_alpha = alpha < 1 && alpha >= 0 && /^hex(3|6)?$/ =~ format

        return to_rgb if use_alpha

        case format.to_s
        when 'rgb'         then to_rgb
        when 'hex', 'hex6' then to_hex
        when 'hex3'        then to_hex(true)
        when 'hex8'        then to_hex8
        when 'hsl'         then to_hsl
        when 'hsv'         then to_hsv
        when 'name'        then to_name(true)
        else                    to_hex
        end
      end

      alias_method :inspect, :to_s

      # Converts to an instance of {ColorModes::Hsv}
      # @return [ColorModes::Hsv]
      def hsv
        Converters::HsvConverter.convert_rgb(@rgb)
      end

      # Converts to an instance of {ColorModes::Hsl}
      # @return [ColorModes::Hsl]
      def hsl
        Converters::HslConverter.convert_rgb(@rgb)
      end

      # Converts to an instance of {ColorModes::Rgb}
      # @return [ColorModes::Rgb]
      attr_reader :rgb

      private

      def to_basic_hex(allow_3 = false)
        r, g, b = [@rgb.r, @rgb.g, @rgb.b].map do |n|
          to_2char_hex(n)
        end

        if allow_3 && r[0] == r[1] && g[0] == g[1] && b[0] == b[1]
          return "#{r[0]}#{g[0]}#{b[0]}"
        end

        "#{[r, g, b].flatten * ''}"
      end

      def to_basic_hex8
        [
          to_2char_hex(alpha * 255),
          to_2char_hex(@rgb.r),
          to_2char_hex(@rgb.g),
          to_2char_hex(@rgb.b)
        ].join('')
      end

      def to_hs(third)
        name = "hs#{third}"
        color = send(name)

        h = color.h.round
        s = (color.s * 100).round
        lv = (color.send(third) * 100).round

        middle = "#{h}, #{s}%, #{lv}%"

        with_alpha(name, middle)
      end

      def with_alpha(mode, middle)
        if alpha < 1
          "#{mode}a(#{middle}, #{rounded_alpha})"
        else
          "#{mode}(#{middle})"
        end
      end
    end
  end
end
