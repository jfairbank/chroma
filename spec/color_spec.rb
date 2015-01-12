require 'spec_helper'

describe Chroma::Color do
  let(:red)       { 'red'.paint }
  let(:other_red) { '#f00'.paint }
  let(:blue)      { 'blue'.paint }

  context 'with equality' do
    it 'equals itself' do
      expect(red).to eql(red)
      expect(red).to eq(red)
    end

    it 'equals another instance of the same color' do
      expect(red).to eql(other_red)
      expect(red).to eq(other_red)
    end

    it 'does not equal another instance of a different color' do
      expect(red).to_not eql(blue)
      expect(red).to_not eq(blue)
    end
  end

  describe '#paint' do
    it 'returns itself' do
      expect(red.paint).to equal(red)
    end
  end
end
