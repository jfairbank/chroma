# General
require 'chroma/version'
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

module Chroma
  class << self
    def paint(input)
      Color.new(input)
    end

    def hex_from_name(name)
      named_colors_map[name]
    end

    def name_from_hex(hex)
      hex_named_colors_map[hex]
    end

    def define_palette(name, &block)
      raise "Palette `#{name}' already exists" if Harmonies.method_defined? name
      PaletteBuilder.build(name, &block)
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
