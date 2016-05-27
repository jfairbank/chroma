module Chroma
  # The main class to represent colors.
  class Color
    include Attributes
    include Serializers
    include Modifiers
    include Helpers::Bounders

    # @param input  [String, ColorModes::Rgb, ColorModes::Hsl, ColorModes::Hsv]
    # @param format [Symbol] the color mode format
    def initialize(input, format = nil)
      @input = input
      @rgb, gen_format = generate_rgb_and_format(input)
      @format = format || gen_format
    end

    # Returns self. Useful for ducktyping situations with {String#paint}.
    #
    # @example
    #   red = 'red'.paint
    #
    #   red.paint            #=> red
    #   red.paint.equal? red #=> true
    #
    # @return [self]
    def paint
      self
    end

    # Returns true if `self` is equal to `other` and they're both instances of
    # {Color}.
    #
    # @example
    #   red = 'red'.paint
    #   blue = 'blue'.paint
    #
    #   red.eql? red          #=> true
    #   red.eql? blue         #=> false
    #   red.eql? '#f00'.paint #=> true
    #
    # @param other [Color]
    # @return      [true, false]
    def eql?(other)
      self.class == other.class && self == other
    end

    # Returns true if both are equal in value.
    #
    # @example
    #   red = 'red'.paint
    #   blue = 'blue'.paint
    #
    #   red == red          #=> true
    #   red == blue         #=> false
    #   red == '#f00'.paint #=> true
    #
    # @param other [Color]
    # @return      [true, false]
    def ==(other)
      to_hex == other.to_hex
    end

    # Returns the complementary color.
    #
    # @example
    #   'red'.paint.complement #=> cyan
    #
    # @return [Color] the complementary color
    def complement
      hsl = self.hsl
      hsl.h = (hsl.h + 180) % 360
      self.class.new(hsl, @format)
    end

    # Returns an instance of {Harmonies} from which to call a palette method.
    #
    # @example
    #   'red'.paint.palette #=> #<Chroma::Harmonies:0x007faf6b9f9148 @color=red>
    #
    # @return [Harmonies]
    def palette
      Harmonies.new(self)
    end

    # Defines a custom palette and immediately returns it. Uses a DSL inside
    # `block` that mirrors the methods in {Color::Modifiers}.
    #
    # @example
    #   'red'.paint.custom_palette do
    #     spin 60
    #     spin 180
    #   end
    #   #=> [red, yellow, cyan]
    #
    # @param block [Proc] the palette definition block
    # @return [Array<Color>] palette array of colors
    def custom_palette(&block)
      PaletteBuilder.build(&block).evaluate(self)
    end

    private

    def to_2char_hex(n)
      n.round.to_s(16).rjust(2, '0')
    end

    def generate_rgb_and_format(input)
      RgbGenerator.generate_rgb_and_format(input)
    end
  end
end
