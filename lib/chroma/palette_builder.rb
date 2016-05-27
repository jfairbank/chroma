module Chroma
  # Class internally used to build custom palettes from {Chroma.define_palette}.
  class PaletteBuilder
    # Wrapper to instantiate a new instance of {PaletteBuilder} and call its
    #   {PaletteBuilder#build} method.
    #
    # @param block [Proc]                             the palette definition block
    # @return      [PaletteBuilder::PaletteEvaluator] lazy palette generator
    def self.build(&block)
      new(&block).build
    end

    # @param block [Proc] the palette definition block
    def initialize(&block)
      @block = block
    end

    # Build the custom palette
    # @return [PaletteBuilder::PaletteEvaluator] lazy palette generator
    def build
      dsl = PaletteBuilderDsl.new
      dsl.instance_eval(&@block)
      dsl.evaluator
    end

    private

    # Internal class for delaying evaluating a color to generate a
    # final palette
    class PaletteEvaluator
      def initialize
        @conversions = []
      end

      def <<(conversion)
        @conversions << conversion
      end

      def evaluate(color)
        @conversions.map do |color_calls|
          color_calls.evaluate(color)
        end.unshift(color)
      end
    end

    # Internal class for palette building DSL syntax.
    class PaletteBuilderDsl
      attr_reader :evaluator

      def initialize
        @evaluator = PaletteEvaluator.new
      end

      def method_missing(name, *args)
        ColorCalls.new(name, args).tap do |color_calls|
          @evaluator << color_calls
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
