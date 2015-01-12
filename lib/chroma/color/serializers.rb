module Chroma
  class Color
    module Serializers
      def to_hsv
        Converters::HsvConverter.convert_rgb(@rgb)
      end

      def to_hsv_s
        to_hs_s(:v)
      end

      def to_hsl
        Converters::HslConverter.convert_rgb(@rgb)
      end

      def to_hsl_s
        to_hs_s(:l)
      end

      def to_hex(allow_3 = false)
        r, g, b = [@rgb.r, @rgb.g, @rgb.b].map do |n|
          to_2char_hex(n)
        end

        if allow_3 && r[0] == r[1] && g[0] == g[1] && b[0] == b[1]
          return "#{r[0]}#{g[0]}#{b[0]}"
        end

        [r, g, b].flatten * ''
      end

      def to_hex_s(allow_3 = false)
        "##{to_hex(allow_3)}"
      end

      def to_hex8
        [
          to_2char_hex(alpha * 255),
          to_2char_hex(@rgb.r),
          to_2char_hex(@rgb.g),
          to_2char_hex(@rgb.b)
        ].join('')
      end

      def to_hex8_s
        "##{to_hex8}"
      end

      def to_rgb
        @rgb
      end

      def to_rgb_s
        middle = @rgb.to_a[0..2].map(&:round).join(', ')

        to_alpha_s(:rgb, middle)
      end

      def to_name
        return 'transparent' if alpha.zero?

        if alpha < 1 || (name = Chroma.name_from_hex(to_hex(true))).nil?
          '<unknown>'
        else
          name
        end
      end

      alias_method :to_name_s, :to_name

      def to_s(format = @format)
        use_alpha = alpha < 1 && alpha >= 0 && /^hex(3|6)?/ =~ format

        return to_rgb_s if use_alpha

        case format.to_s
        when 'rgb'         then to_rgb_s
        when 'hex', 'hex6' then to_hex_s
        when 'hex3'        then to_hex_s(true)
        when 'hex8'        then to_hex8_s
        when 'hsl'         then to_hsl_s
        when 'hsv'         then to_hsv_s
        when 'name'        then to_name
        else                    to_hex_s
        end
      end

      alias_method :inspect, :to_s

      private

      def to_hs_s(third)
        color = send("to_hs#{third}")

        h = color.h.round
        s = (color.s * 100).round
        lv = (color.send(third) * 100).round

        middle = "#{h}, #{s}%, #{lv}%"

        to_alpha_s("hs#{third}", middle)
      end

      def to_alpha_s(mode, middle)
        if alpha < 1
          "#{mode}a(#{middle}, #{rounded_alpha})"
        else
          "#{mode}(#{middle})"
        end
      end
    end
  end
end
