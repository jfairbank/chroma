module Chroma
  class Color
    # Attribute methods for {Color}.
    module Attributes
      attr_reader :format

      # Determines if the color is dark.
      #
      # @example
      #   'red'.paint.dark?    #=> true
      #   'yellow'.paint.dark? #=> false
      #
      # @return [true, false]
      def dark?
        brightness < 128
      end

      # Determines if the color is light.
      #
      # @example
      #   'red'.paint.light?    #=> false
      #   'yellow'.paint.light? #=> true
      #
      # @return [true, false]
      def light?
        !dark?
      end

      # Returns the alpha channel value.
      #
      # @example
      #   'red'.paint.alpha                #=> 1.0
      #   'rgba(0, 0, 0, 0.5)'.paint.alpha #=> 0.5
      #
      # @return [Float]
      def alpha
        @rgb.a
      end

      # Calculates the brightness.
      #
      # @example
      #   'red'.paint.brightness    #=> 76.245
      #   'yellow'.paint.brightness #=> 225.93
      #
      # @return [Float]
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
