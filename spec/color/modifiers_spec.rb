describe Chroma::Color do
  let(:red)    { 'red'.paint }
  let(:yellow) { 'yellow'.paint }

  describe '#lighten' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.lighten).to eq '#ff3333'.paint
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.lighten(20)).to eq '#ff6666'.paint
      end
    end
  end

  describe '#brighten' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.brighten).to eq '#ff1a1a'.paint
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.brighten(20)).to eq '#ff3333'.paint
      end
    end
  end

  describe '#darken' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.darken).to eq '#cc0000'.paint
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.darken(20)).to eq '#990000'.paint
      end
    end
  end

  describe '#desaturate' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect(red.desaturate).to eq '#f20d0d'.paint
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect(red.desaturate(20)).to eq '#e61919'.paint
      end
    end
  end

  describe '#saturate' do
    context 'with default amount' do
      it 'generates the correct color' do
        expect('#123'.paint.saturate).to eq '#0e2236'.paint
      end
    end

    context 'with supplied amount' do
      it 'generates the correct color' do
        expect('#123'.paint.saturate(20)).to eq '#0a223a'.paint
      end
    end
  end

  describe '#grayscale' do
    it 'generates the correct color' do
      expect(red.grayscale).to           eq 'gray'.paint
      expect('green'.paint.grayscale).to eq '#404040'.paint
    end
  end

  describe '#opacity' do
    it 'sets color opacity to supplied amount' do
      green_a = 'rgba(0, 128, 0, 0.5)'
      expect(green_a.paint.opacity(1)).to eq 'rgba(0, 128, 0, 1)'.paint
      expect('green'.paint.opacity(0)).to eq 'rgba(0, 128, 0, 0)'.paint
      expect(red.opacity(0.3)).to         eq 'rgba(100%, 0%, 0%, 0.3)'.paint
    end
  end

  describe '#spin' do
    it 'generates the correct color' do
      expect(red.spin(60)).to eq yellow
    end
  end
end
