module Chroma
  class Color
    module Attributes
      attr_reader :format

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

      private

      def rounded_alpha
        @rounded_alpha ||= (alpha * 100).round / 100.0
      end
    end
  end
end
