module Chroma
  module RgbGenerator
    class FromString < Base
      # Returns the regex matchers and rgb generation classes for various
      # string color formats.
      #
      # @api private
      # @return [Hash<Symbol, Hash>]
      def self.matchers
        @matchers ||= begin
          # TinyColor.js matchers
          css_int = '[-\\+]?\\d+%?'
          css_num = '[-\\+]?\\d*\\.\\d+%?'
          css_unit = "(?:#{css_num})|(?:#{css_int})"
          permissive_prefix = '[\\s|\\(]+('
          permissive_delim = ')[,|\\s]+('
          permissive_suffix = ')\\s*\\)?'
          permissive_match3 = "#{permissive_prefix}#{[css_unit] * 3 * permissive_delim}#{permissive_suffix}"
          permissive_match4 = "#{permissive_prefix}#{[css_unit] * 4 * permissive_delim}#{permissive_suffix}"
          hex_match = '[0-9a-fA-F]'

          {
            rgb:  { regex: /rgb#{permissive_match3}/,        class_name: :FromRgbValues },
            rgba: { regex: /rgba#{permissive_match4}/,       class_name: :FromRgbValues },
            hsl:  { regex: /hsl#{permissive_match3}/,        class_name: :FromHslValues },
            hsla: { regex: /hsla#{permissive_match4}/,       class_name: :FromHslValues },
            hsv:  { regex: /hsv#{permissive_match3}/,        class_name: :FromHsvValues },
            hsva: { regex: /hsva#{permissive_match4}/,       class_name: :FromHsvValues },
            hex3: { regex: /^#?#{"(#{hex_match}{1})" * 3}$/, class_name: :FromHexStringValues, builder: :from_hex3 },
            hex6: { regex: /^#?#{"(#{hex_match}{2})" * 3}$/, class_name: :FromHexStringValues, builder: :from_hex6 },
            hex8: { regex: /^#?#{"(#{hex_match}{2})" * 4}$/, class_name: :FromHexStringValues, builder: :from_hex8 }
          }.freeze
        end
      end

      # @param format [Symbol] unused
      # @param input  [String] input to parse
      def initialize(format, input)
        @input = normalize_input(input)
      end

      # Generates a {ColorModes::Rgb}.
      # @return [ColorModes::Rgb]
      def generate
        get_generator.generate
      end

      private

      def get_generator
        if color = Chroma.hex_from_name(@input)
          format = :name
        elsif @input == 'transparent'
          return FromRgbValues.new(:name, 0, 0, 0, 0)
        else
          format = nil
          color = @input
        end

        match = nil

        _, hash = matchers.find do |_, h|
          !(match = h[:regex].match(color)).nil?
        end

        if match.nil?
          raise Errors::UnrecognizedColor, "Unrecognized color `#{color}'"
        end

        build_generator(match[1..-1], hash[:class_name], hash[:builder], format)
      end

      def build_generator(args, class_name, builder, format)
        builder ||= :new
        klass = RgbGenerator.const_get(class_name)
        klass.__send__(builder, *([format] + args))
      end

      def normalize_input(input)
        input.strip.downcase
      end

      def matchers
        self.class.matchers
      end
    end
  end
end
