module Chroma
  module ColorModes
    class << self
      private

      # Builds a new color mode class.
      #
      # @param name  [String]        the class name
      # @param attrs [Array<Symbol>] the instance attribute names
      # @!macro [attach] build
      #   @!parse class $1
      #     attr_accessor :$2, :$3, :$4, :a
      #
      #     # @param $2 [Numeric]
      #     # @param $3 [Numeric]
      #     # @param $4 [Numeric]
      #     # @param a [Numeric]
      #     def initialize(${2-4}, a = 1)
      #       @$2, @$3, @$4, @a = $2, $3, $4, a
      #     end
      #
      #     # Returns the values `$2`, `$3`, `$4`, and `a` as an array.
      #     #
      #     # @return [Array<Numeric>]
      #     def to_a
      #       [@$2, @$3, @$4, @a]
      #     end
      #
      #     alias_method :to_ary, :to_a
      #     end
      def build(name, *attrs)
        class_eval <<-EOS
          class #{name}
            attr_accessor #{(attrs + [:a]).map{|attr| ":#{attr}"} * ', '}

            def initialize(#{attrs * ', '}, a = 1)
              #{attrs.map{|attr| "@#{attr}"} * ', '}, @a = #{attrs * ', '}, a
            end

            def to_a
              [#{attrs.map{|attr| "@#{attr}"} * ', '}, @a]
            end

            alias_method :to_ary, :to_a
          end
        EOS
      end
    end

    private

    build 'Rgb', :r, :g, :b
    build 'Hsl', :h, :s, :l
    build 'Hsv', :h, :s, :v
  end
end
