module Chroma
  # Class internally used to build custom palettes from {Chroma.define_palette}.
  class PaletteBuilder
    # Wrapper to instantiate a new instance of {PaletteBuilder} and call its
    #   {PaletteBuilder#build} method.
    #
    # @param name  [Symbol, String] the name of the custom palette
    # @param block [Proc]           the palette definition block
    # @return      [Symbol, String] the name of the custom palette
    def self.build(name, &block)
      new(name, &block).build
    end

    # @param name  [Symbol, String] the name of the custom palette
    # @param block [Proc]           the palette definition block
    def initialize(name, &block)
      @name = name
      @block = block
    end

    # Build the custom palette by defining a new method on {Harmonies}.
    # @return [Symbol, String] the name of the custom palette
    def build
      dsl = PaletteBuilderDsl.new
      dsl.instance_eval(&@block)
      conversions = dsl.conversions

      Harmonies.send(:define_method, @name) do
        conversions.map do |color_calls|
          color_calls.evaluate(@color)
        end.unshift(@color)
      end
    end

    private

    # Internal class for palette building DSL syntax.
    class PaletteBuilderDsl
      attr_reader :conversions

      def initialize
        @conversions = []
      end

      def method_missing(name, *args)
        ColorCalls.new(name, args).tap do |color_calls|
          @conversions << color_calls
        end
      end

      # Internal class to represent color modification calls in the palette
      # builder DSL definition syntax.
      class ColorCalls
        attr_reader :name, :args

        def initialize(name, args)
          @calls = [[name, args]]
        end

        def evaluate(color)
          @calls.reduce(color) do |c, (name, args)|
            c.send(name, *args)
          end
        end

        def method_missing(name, *args)
          @calls << [name, args]
        end
      end
    end
  end
end
