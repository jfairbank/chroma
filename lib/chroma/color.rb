module Chroma
  class Color
    include Attributes
    include Serializers
    include Modifiers
    include Helpers::Bounders

    def initialize(input, format = nil)
      @input = input
      @rgb, gen_format = generate_rgb_and_format(input)
      @format = format || gen_format
    end

    def paint
      self
    end

    def eql?(other)
      self.class == other.class && self == other
    end

    def ==(other)
      to_hex_s == other.to_hex_s
    end

    def complement
      hsl = to_hsl
      hsl.h = (hsl.h + 180) % 360
      Color.new(hsl)
    end

    def palette
      Harmonies.new(self)
    end

    protected

    attr_reader :rgb

    private

    def to_2char_hex(n)
      n.round.to_s(16).rjust(2, '0')
    end

    def generate_rgb_and_format(input)
      RgbGenerator.generate_rgb_and_format(input)
    end
  end
end
