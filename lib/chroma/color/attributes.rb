module Chroma
  class Color
    module Attributes
      def dark?
        brightness < 128
      end

      def light?
        !dark?
      end

      def alpha
        @rgb.a
      end

      def brightness
        (@rgb.r * 299 + @rgb.g * 587 + @rgb.b * 114) / 1000.0
      end
    end
  end
end
