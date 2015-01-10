module Chroma
  module Helpers
    module Bounders
      def bound01(n, max)
        is_percent = n.to_s.include? '%'
        n = [max, [0, n.to_f].max].min
        n = (n * max).to_i / 100 if is_percent

        return 1 if (n - max).abs < 0.000001

        (n % max) / max.to_f
      end

      def bound_alpha(a)
        a = a.to_f
        a = 1 if a < 0 || a > 1
        a
      end

      def clamp01(n)
        [1, [0, n].max].min
      end

      def to_percentage(n)
        n = n.to_f
        n = "#{n * 100}%" if n <= 1
        n
      end
    end
  end
end
