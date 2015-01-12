require 'spec_helper'

describe Chroma::Color do
  describe '#spin' do
    it 'generates the correct color' do
      expect('red'.paint.spin(60)).to eq('yellow'.paint)
    end
  end
end
