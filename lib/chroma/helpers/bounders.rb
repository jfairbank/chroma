module Chroma
  module Helpers
    module Bounders
      # Bounds a value `n` that is from `0` to `max` to `0` to `1`.
      #
      # @param n   [Numeric, String]
      # @param max [Fixnum]
      # @return    [Float]
      def bound01(n, max)
        is_percent = n.to_s.include? '%'
        n = [max, [0, n.to_f].max].min
        n = (n * max).to_i / 100.0 if is_percent

        return 1 if (n - max).abs < 0.000001

        (n % max) / max.to_f
      end

      # Ensure alpha value `a` is between `0` and `1`.
      #
      # @param a [Numeric, String] alpha value
      # @return  [Numeric]
      def bound_alpha(a)
        a = a.to_f
        a = 1 if a < 0 || a > 1
        a
      end

      # Ensures a number between `0` and `1`. Returns `n` if it is between `0`
      #   and `1`.
      #
      # @param n [Numeric]
      # @return  [Numeric]
      def clamp01(n)
        [1, [0, n].max].min
      end

      # Converts `n` to a percentage type value.
      #
      # @param n [Numeric, String]
      # @return  [String, Float]
      def to_percentage(n)
        n = n.to_f
        n = "#{n * 100}%" if n <= 1
        n
      end
    end
  end
end
