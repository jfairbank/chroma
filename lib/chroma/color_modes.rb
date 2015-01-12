module Chroma
  module ColorModes
    class << self
      private

      def build(name, *attrs)
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

            protected

            def to_rgb
              Converters::RgbConverter.convert_#{name}(self)
            end

            def to_hsl
              Converters::HslConverter.convert_#{name}(self)
            end

            def to_hsv
              Converters::HsvConverter.convert_#{name}(self)
            end
          EOS
        end
      end
    end

    Rgb = build :rgb, :r, :g, :b
    Hsl = build :hsl, :h, :s, :l
    Hsv = build :hsv, :h, :s, :v
  end
end
