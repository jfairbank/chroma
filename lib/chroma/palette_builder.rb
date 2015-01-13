module Chroma
  class PaletteBuilder
    def self.build(name, &block)
      new(name, &block).build
    end

    def initialize(name, &block)
      @name = name
      @block = block
    end

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
