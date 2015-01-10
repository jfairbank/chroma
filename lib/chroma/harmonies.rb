module Chroma
  class Harmonies
    def initialize(color)
      @color = color
    end

    def complement
      [@color, @color.complement]
    end

    def triad
      hsl_map([0, 120, 240])
    end

    def tetrad
      hsl_map([0, 90, 180, 270])
    end

    def split_complement
      hsl_map([0, 72, 216])
    end

    def analogous(results = 6, slices = 30)
      hsl = @color.to_hsl
      part = 360 / slices
      hsl.h = ((hsl.h - (part * results >> 1)) + 720) % 360

      (results - 1).times.reduce([@color]) do |arr, n|
        hsl.h = (hsl.h + part) % 360
        arr << Color.new(hsl)
      end
    end

    def monochromatic(results = 6)
      h, s, v = @color.to_hsv
      modification = 1.0 / results

      results.times.map do
        Color.new(ColorModes::Hsv.new(h, s, v)).tap do
          v = (v + modification) % 1
        end
      end
    end

    private

    def hsl_map(degrees)
      h, s, l = @color.to_hsl

      degrees.map do |deg|
        Color.new(ColorModes::Hsl.new((h + deg) % 360, s, l))
      end
    end
  end
end
