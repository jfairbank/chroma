describe Chroma::Color do
  let(:red)    { 'red'.paint }
  let(:black)  { 'black'.paint }
  let(:white)  { 'white'.paint }
  let(:yellow) { 'yellow'.paint }

  describe '#dark?' do
    it 'returns true for dark colors' do
      expect(red).to   be_dark
      expect(black).to be_dark
    end

    it 'returns false for light colors' do
      expect(white).to_not  be_dark
      expect(yellow).to_not be_dark
    end
  end

  describe '#light?' do
    it 'returns false for dark colors' do
      expect(red).to_not   be_light
      expect(black).to_not be_light
    end

    it 'returns true for light colors' do
      expect(white).to  be_light
      expect(yellow).to be_light
    end
  end

  describe '#alpha' do
    it 'returns the correct alpha value' do
      expect('rgba(255, 0, 0, 0.75)'.paint.alpha).to eq 0.75
      expect('#80ff0000'.paint.alpha).to             be_within(0.01).of(0.5)
      expect('transparent'.paint.alpha).to           eq 0
      expect('hsla(0, 100%, 50%, 0'.paint.alpha).to  eq 0
      expect(red.alpha).to                           eq 1
    end
  end

  describe '#brightness' do
    it 'returns the correct brightness' do
      expect(red.brightness).to    eq 76.245
      expect(black.brightness).to  eq 0
      expect(white.brightness).to  eq 255
      expect(yellow.brightness).to eq 225.93
    end
  end
end
