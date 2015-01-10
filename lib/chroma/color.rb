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

    def complement
      hsl = to_hsl
      hsl.h = (hsl.h + 180) % 360
      Color.new(hsl)
    end

    def palette
      Harmonies.new(self)
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
