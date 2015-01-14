describe Chroma do
  describe '.hex_from_name' do
    it 'returns the hex representation for a color name' do
      Chroma.send(:named_colors_map).each do |name, hex|
        expect(Chroma.hex_from_name(name)).to eq hex
      end
    end

    it 'returns nil for unknown colors names' do
      expect(Chroma.hex_from_name('foo')).to be_nil
    end
  end

  describe '.name_from_hex' do
    it 'returns a color name for a hex representation' do
      Chroma.send(:named_colors_map).each do |name, hex|
        expect(Chroma.name_from_hex(hex)).to be
      end
    end

    it 'returns nil for hex values without a corresponding color name' do
      expect(Chroma.name_from_hex('#123123')).to be_nil
    end
  end
end
