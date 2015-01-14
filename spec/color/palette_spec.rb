describe Chroma::Color, '#palette' do
  let(:red) { 'red'.paint }

  def palette(name, *args)
    red.palette.send(name, *args)
  end

  it 'returns an instance of Harmonies' do
    expect(red.palette).to be_a Chroma::Harmonies
  end

  describe '#complement' do
    it 'returns the color and its complement' do
      expect(red.palette.complement).to generate_palette %w(red cyan)
    end

    it 'keeps the same format' do
      expect(red.palette.complement).to all have_format :name
    end

    context 'with option :as' do
      it 'outputs the palette as an array of the string format' do
        expect(red.palette.complement(as: :hex)).
          to eq %w(#ff0000 #00ffff)
      end
    end
  end

  describe '#triad' do
    it 'returns the triad palette' do
      expect(red.palette.triad).to generate_palette %w(red lime blue)
    end

    it 'keeps the same format' do
      expect(red.palette.triad).to all have_format :name
    end

    context 'with option :as' do
      it 'outputs the palette as an array of the string format' do
        expect(red.palette.triad(as: :hex)).
          to eq %w(#ff0000 #00ff00 #0000ff)
      end
    end
  end

  describe '#tetrad' do
    it 'returns the tetrad palette' do
      expect(red.palette.tetrad).to generate_palette %w(red #80ff00 cyan #7f00ff)
    end

    it 'keeps the same format' do
      expect(red.palette.tetrad).to all have_format :name
    end

    context 'with option :as' do
      it 'outputs the palette as an array of the string format' do
        expect(red.palette.tetrad(as: :hex)).
          to eq %w(#ff0000 #80ff00 #00ffff #7f00ff)
      end
    end
  end

  describe '#split_complement' do
    it 'returns the split complement palette' do
      expect(red.palette.split_complement).to generate_palette %w(red #cf0 #06f)
    end

    it 'keeps the same format' do
      expect(red.palette.split_complement).to all have_format :name
    end

    context 'with option :as' do
      it 'outputs the palette as an array of the string format' do
        expect(red.palette.split_complement(as: :hex)).
          to eq %w(#ff0000 #ccff00 #0066ff)
      end
    end
  end

  describe '#analogous' do
    context 'with default parameters' do
      it 'returns the analogous palette' do
        expect(red.palette.analogous).
          to generate_palette %w(#f00 #f06 #f03 #f00 #f30 #f60)
      end

      it 'keeps the same format' do
        expect(red.palette.analogous).to all have_format :name
      end

      context 'with option :as' do
        it 'outputs the palette as an array of the string format' do
          expect(red.palette.analogous(as: :hex)).
            to eq %w(#ff0000 #ff0066 #ff0033 #ff0000 #ff3300 #ff6600)
        end
      end
    end

    context 'with `size` argument' do
      it 'returns the analogous palette' do
        expect(red.palette.analogous(size: 3)).
          to generate_palette %w(#f00 #ff001a #ff1a00)
      end

      it 'keeps the same format' do
        expect(red.palette.analogous(size: 3)).to all have_format :name
      end

      context 'with option :as' do
        it 'outputs the palette as an array of the string format' do
          expect(red.palette.analogous(size: 3, as: :hex)).
            to eq %w(#ff0000 #ff001a #ff1a00)
        end
      end
    end

    context 'with `size` and `slice_by` arguments' do
      it 'returns the analogous palette' do
        expect(red.palette.analogous(size: 3, slice_by: 10)).
          to generate_palette %w(#f00 #ff004c #ff4d00)
      end

      it 'keeps the same format' do
        expect(red.palette.analogous(size: 3, slice_by: 10)).to all have_format :name
      end

      context 'with option :as' do
        it 'outputs the palette as an array of the string format' do
          expect(red.palette.analogous(size: 3, slice_by: 10, as: :hex)).
            to eq %w(#ff0000 #ff004c #ff4d00)
        end
      end
    end
  end

  describe '#monochromatic' do
    context 'with default parameters' do
      it 'returns the monochromatic palette' do
        expect(red.palette.monochromatic).
          to generate_palette %w(#f00 #2a0000 #500 #800000 #a00 #d40000)
      end

      it 'keeps the same format' do
        expect(red.palette.monochromatic).to all have_format :name
      end

      context 'with option :as' do
        it 'outputs the palette as an array of the string format' do
          expect(red.palette.monochromatic(as: :hex)).
            to eq %w(#ff0000 #2a0000 #550000 #800000 #aa0000 #d40000)
        end
      end
    end

    context 'with `size` argument' do
      it 'returns the monochromatic palette' do
        expect(red.palette.monochromatic(size: 3)).
          to generate_palette %w(#f00 #500 #a00)
      end

      it 'keeps the same format' do
        expect(red.palette.monochromatic(size: 3)).to all have_format :name
      end

      context 'with option :as' do
        it 'outputs the palette as an array of the string format' do
          expect(red.palette.monochromatic(size: 3, as: :hex)).
            to eq %w(#ff0000 #550000 #aa0000)
        end
      end
    end
  end
end
