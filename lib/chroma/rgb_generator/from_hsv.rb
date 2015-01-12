module Chroma
  module RgbGenerator
    class FromHsv < Base
      def initialize(format, hsv)
        @format = format
        @hsv = hsv
      end

      def generate
        FromHsvValues.new(@format, *@hsv.to_a).generate
      end
    end
  end
end
