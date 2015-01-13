describe Chroma, '.define_palette' do
  def add_palette
    Chroma.define_palette :foo do
      spin 60
      spin 180
      spin(60).brighten(20)
      greyscale
    end
  end

  def remove_palette
    if Chroma::Harmonies.method_defined? :foo
      Chroma::Harmonies.send(:remove_method, :foo)
    end
  end

  after(:example) { remove_palette }

  let(:red) { '#ff0000'.paint }

  it 'adds the new palette method' do
    expect(red.palette).to_not respond_to(:foo)
    add_palette
    expect(red.palette).to respond_to(:foo)
  end

  it 'generates the correct colors' do
    add_palette

    expect(red.palette.foo).
      to generate_palette %w(#ff0000 #ffff00 #00ffff #ffff33 #808080)
  end

  it 'keeps the same format' do
    add_palette

    expect('red'.paint.palette.foo).to all have_format :name
  end
end
