# General
require 'chroma/version'
require 'chroma/errors'
require 'yaml'

# Modules
require 'chroma/helpers/bounders'

# Color
require 'chroma/color/attributes'
require 'chroma/color/serializers'
require 'chroma/color/modifiers'
require 'chroma/color'
require 'chroma/color_modes'

# Palettes
require 'chroma/harmonies'
require 'chroma/palette_builder'

# RGB Generators
require 'chroma/rgb_generator'
require 'chroma/rgb_generator/base'
require 'chroma/rgb_generator/from_string'
require 'chroma/rgb_generator/from_rgb_values'
require 'chroma/rgb_generator/from_rgb'
require 'chroma/rgb_generator/from_hsl_values'
require 'chroma/rgb_generator/from_hsl'
require 'chroma/rgb_generator/from_hsv_values'
require 'chroma/rgb_generator/from_hsv'
require 'chroma/rgb_generator/from_hex_string_values'

# Converters
require 'chroma/converters/base'
require 'chroma/converters/rgb_converter'
require 'chroma/converters/hsl_converter'
require 'chroma/converters/hsv_converter'

# Extensions
require 'chroma/extensions/string'

# The main module.
module Chroma
  class << self
    # Returns a new instance of color. Supports hexadecimal, rgb, rgba, hsl,
    # hsla, hsv, hsva, and named color formats.
    #
    # @api public
    #
    # @example
    #   Chroma.paint('red')
    #   Chroma.paint('#f00')
    #   Chroma.paint('#ff0000')
    #   Chroma.paint('rgb(255, 0, 0)')
    #   Chroma.paint('hsl(0, 100%, 50%)')
    #   Chroma.paint('hsv(0, 100%, 100%)')
    #
    # @param input [String] the color
    # @return      [Color]  an instance of {Color}
    def paint(input)
      Color.new(input)
    end

    # Returns the hexadecimal string representation of a named color and nil
    # if no match is found. Favors 3-character hexadecimal if possible.
    #
    # @example
    #   Chroma.hex_from_name('red')       #=> 'f00'
    #   Chroma.hex_from_name('aliceblue') #=> 'f0f8ff'
    #   Chroma.hex_from_name('foo')       #=> nil
    #
    # @param name [String]      the color name
    # @return     [String, nil] the color as a string hexadecimal or nil
    def hex_from_name(name)
      named_colors_map[name]
    end

    # Returns the color name of a hexadecimal color if available and nil if no
    # match is found. Requires 3-character hexadecimal input for applicable
    # colors.
    #
    # @example
    #   Chroma.name_from_hex('f00')    #=> 'red'
    #   Chroma.name_from_hex('f0f8ff') #=> 'aliceblue'
    #   Chroma.name_from_hex('123123') #=> nil
    #
    # @param hex [String]      the hexadecimal color
    # @return    [String, nil] the color name or nil
    def name_from_hex(hex)
      hex_named_colors_map[hex]
    end

    # Defines a custom palette for use by {Color#palette}. Uses a DSL inside
    # `block` that mirrors the methods in {Color::Modifiers}.
    #
    # @example
    #   'red'.paint.palette.respond_to? :my_palette #=> false
    #
    #   Chroma.define_palette :my_palette do
    #     spin 60
    #     spin 120
    #     spin 240
    #   end
    #
    #   'red'.paint.palette.respond_to? :my_palette #=> true
    #
    # @param name  [Symbol, String]              the name of the custom palette
    # @param block [Proc]                        the palette definition block
    # @raise       [Errors::PaletteDefinedError] if the palette is already defined
    # @return      [Symbol, String]              the name of the custom palette
    def define_palette(name, &block)
      if Harmonies.method_defined? name
        raise Errors::PaletteDefinedError, "Palette `#{name}' already exists"
      end

      palette_evaluator = PaletteBuilder.build(&block)

      Harmonies.send(:define_method, name) do
        palette_evaluator.evaluate(@color)
      end
    end

    private

    def hex_named_colors_map
      @hex_named_colors_map ||= named_colors_map.invert
    end

    def named_colors_map
      @named_colors ||= YAML.load_file(File.expand_path('../support/named_colors.yml', __FILE__))
    end
  end
end
