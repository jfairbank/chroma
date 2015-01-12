require 'spec_helper'

describe Chroma do
  describe '.paint' do
    context 'with named color' do
      it 'creates a color' do
        expect(Chroma.paint('red')).to be_a(Chroma::Color)
      end
    end

    context 'with 6 character hexadecimal' do
      it 'creates a color' do
        expect(Chroma.paint('#ff0000')).to be_a(Chroma::Color)
        expect(Chroma.paint('ff0000')).to be_a(Chroma::Color)
      end
    end

    context 'with 3 character hexadecimal' do
      it 'creates a color' do
        expect(Chroma.paint('#f00')).to be_a(Chroma::Color)
        expect(Chroma.paint('f00')).to be_a(Chroma::Color)
      end
    end

    context 'with 8 character hexadecimal' do
      let(:hex) { '#80ff0000' }

      it 'creates a color' do
        expect(Chroma.paint(hex)).to be_a(Chroma::Color)
        expect(Chroma.paint(hex[1..-1])).to be_a(Chroma::Color)
      end

      it 'sets alpha' do
        expect(Chroma.paint(hex).alpha).to be_within(0.1).of(0.5)
      end
    end

    context 'with rgb' do
      it 'creates a color' do
        expect(Chroma.paint('rgb(255, 0, 0)')).to be_a(Chroma::Color)
        expect(Chroma.paint('rgba(255, 0, 0, 0.5)')).to be_a(Chroma::Color)
      end

      it 'sets alpha' do
        expect(Chroma.paint('rgba(255, 0, 0, 0.5)').alpha).to eq(0.5)
      end
    end

    context 'with hsl' do
      it 'creates a color' do
        expect(Chroma.paint('hsl(120, 100%, 50%)')).to be_a(Chroma::Color)
      end
    end
  end
end
