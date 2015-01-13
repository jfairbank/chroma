module Chroma
  class Color
    module Serializers
      def to_hsv
        to_hs(:v)
      end

      def to_hsl
        to_hs(:l)
      end

      def to_hex(allow_3 = false)
        "##{to_basic_hex(allow_3)}"
      end

      def to_hex8
        "##{to_basic_hex8}"
      end

      def to_rgb
        middle = @rgb.to_a[0..2].map(&:round).join(', ')

        with_alpha(:rgb, middle)
      end

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

      def hsv
        Converters::HsvConverter.convert_rgb(@rgb)
      end

      def hsl
        Converters::HslConverter.convert_rgb(@rgb)
      end

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
