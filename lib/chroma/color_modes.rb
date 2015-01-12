module Chroma
  module ColorModes
    class << self
      private

      def build(*attrs)
        Class.new do
          attr_accessor *(attrs + [:a])

          class_eval <<-EOS
            def initialize(#{attrs * ', '}, a = 1)
              #{attrs.map{|attr| "@#{attr}"} * ', '}, @a = #{attrs * ', '}, a
            end

            def to_a
              [#{attrs.map{|attr| "@#{attr}"} * ', '}, @a]
            end

            alias_method :to_ary, :to_a
          EOS
        end
      end
    end

    Rgb = build :r, :g, :b
    Hsl = build :h, :s, :l
    Hsv = build :h, :s, :v
  end
end
