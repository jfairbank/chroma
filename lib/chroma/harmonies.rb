module Chroma
  class Harmonies
    def initialize(color)
      @color = color
    end

    def complement(options = {})
      with_reformat([@color, @color.complement], options[:as])
    end

    def triad(options = {})
      hsl_map([0, 120, 240], options)
    end

    def tetrad(options = {})
      hsl_map([0, 90, 180, 270], options)
    end

    def split_complement(options = {})
      hsl_map([0, 72, 216], options)
    end

    def analogous(options = {})
      results = options[:results] || 6
      slices = options[:slices] || 30

      hsl = @color.hsl
      part = 360 / slices
      hsl.h = ((hsl.h - (part * results >> 1)) + 720) % 360

      palette = (results - 1).times.reduce([@color]) do |arr, n|
        hsl.h = (hsl.h + part) % 360
        arr << Color.new(hsl, @color.format)
      end

      with_reformat(palette, options[:as])
    end

    def monochromatic(options = {})
      results = options[:results] || 6

      h, s, v = @color.hsv
      modification = 1.0 / results

      palette = results.times.map do
        Color.new(ColorModes::Hsv.new(h, s, v), @color.format).tap do
          v = (v + modification) % 1
        end
      end

      with_reformat(palette, options[:as])
    end

    private

    def with_reformat(palette, as)
      palette.map! { |color| color.to_s(as) } unless as.nil?
      palette
    end

    def hsl_map(degrees, options)
      h, s, l = @color.hsl

      degrees.map! do |deg|
        Color.new(ColorModes::Hsl.new((h + deg) % 360, s, l), @color.format)
      end

      with_reformat(degrees, options[:as])
    end
  end
end
