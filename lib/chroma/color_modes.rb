module Chroma
  module ColorModes
    class << self
      private

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

    build 'Rgb', :r, :g, :b
    build 'Hsl', :h, :s, :l
    build 'Hsv', :h, :s, :v
  end
end
