module Chroma
  # Class to hold all palette methods.
  class Harmonies
    # @param color [Color]
    def initialize(color)
      @color = color
    end

    # Generate a complement palette.
    #
    # @example
    #   'red'.paint.palette.complement            #=> [red, cyan]
    #   'red'.paint.palette.complement(as: :name) #=> ['red', 'cyan']
    #   'red'.paint.palette.complement(as: :hex)  #=> ['#ff0000', '#00ffff']
    #
    # @param options [Hash]
    # @option options :as [Symbol] (nil) optional format to output colors as strings
    # @return [Array<Color>, Array<String>] depending on presence of `options[:as]`
    def complement(options = {})
      with_reformat([@color, @color.complement], options[:as])
    end

    # Generate a triad palette.
    #
    # @example
    #   'red'.paint.palette.triad            #=> [red, lime, blue]
    #   'red'.paint.palette.triad(as: :name) #=> ['red', 'lime', 'blue']
    #   'red'.paint.palette.triad(as: :hex)  #=> ['#ff0000', '#00ff00', '#0000ff']
    #
    # @param options [Hash]
    # @option options :as [Symbol] (nil) optional format to output colors as strings
    # @return [Array<Color>, Array<String>] depending on presence of `options[:as]`
    def triad(options = {})
      hsl_map([0, 120, 240], options)
    end

    # Generate a tetrad palette.
    #
    # @example
    #   'red'.paint.palette.tetrad            #=> [red, #80ff00, cyan, #7f00ff]
    #   'red'.paint.palette.tetrad(as: :name) #=> ['red', '#80ff00', 'cyan', '#7f00ff']
    #   'red'.paint.palette.tetrad(as: :hex)  #=> ['#ff0000', '#80ff00', '#00ffff', '#7f00ff']
    #
    # @param options [Hash]
    # @option options :as [Symbol] (nil) optional format to output colors as strings
    # @return [Array<Color>, Array<String>] depending on presence of `options[:as]`
    def tetrad(options = {})
      hsl_map([0, 90, 180, 270], options)
    end

    # Generate a split complement palette.
    #
    # @example
    #   'red'.paint.palette.split_complement            #=> [red, #ccff00, #0066ff]
    #   'red'.paint.palette.split_complement(as: :name) #=> ['red', '#ccff00', '#0066ff']
    #   'red'.paint.palette.split_complement(as: :hex)  #=> ['#ff0000', '#ccff00', '#0066ff']
    #
    # @param options [Hash]
    # @option options :as [Symbol] (nil) optional format to output colors as strings
    # @return [Array<Color>, Array<String>] depending on presence of `options[:as]`
    def split_complement(options = {})
      hsl_map([0, 72, 216], options)
    end

    # Generate an analogous palette.
    #
    # @example
    #   'red'.paint.palette.analogous                        #=> [red, #ff0066, #ff0033, red, #ff3300, #ff6600]
    #   'red'.paint.palette.analogous(as: :hex)              #=> ['#f00', '#f06', '#f03', '#f00', '#f30', '#f60']
    #   'red'.paint.palette.analogous(size: 3)               #=> [red, #ff001a, #ff1a00]
    #   'red'.paint.palette.analogous(size: 3, slice_by: 60) #=> [red, #ff000d, #ff0d00]
    #
    # @param options [Hash]
    # @option options :size     [Symbol] (6) number of results to return
    # @option options :slice_by [Symbol] (30)
    #   the angle in degrees to slice the hue circle per color
    # @option options :as       [Symbol] (nil) optional format to output colors as strings
    # @return [Array<Color>, Array<String>] depending on presence of `options[:as]`
    def analogous(options = {})
      size = options[:size] || 6
      slices = options[:slice_by] || 30

      hsl = @color.hsl
      part = 360 / slices
      hsl.h = ((hsl.h - (part * size >> 1)) + 720) % 360

      palette = (size - 1).times.reduce([@color]) do |arr, n|
        hsl.h = (hsl.h + part) % 360
        arr << Color.new(hsl, @color.format)
      end

      with_reformat(palette, options[:as])
    end

    # Generate a monochromatic palette.
    #
    # @example
    #   'red'.paint.palette.monochromatic           #=> [red, #2a0000, #550000, maroon, #aa0000, #d40000]
    #   'red'.paint.palette.monochromatic(as: :hex) #=> ['#ff0000', '#2a0000', '#550000', '#800000', '#aa0000', '#d40000']
    #   'red'.paint.palette.monochromatic(size: 3)  #=> [red, #550000, #aa0000]
    #
    # @param options [Hash]
    # @option options :size [Symbol] (6) number of results to return
    # @option options :as   [Symbol] (nil) optional format to output colors as strings
    # @return [Array<Color>, Array<String>] depending on presence of `options[:as]`
    def monochromatic(options = {})
      size = options[:size] || 6

      h, s, v = @color.hsv
      modification = 1.0 / size

      palette = size.times.map do
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
