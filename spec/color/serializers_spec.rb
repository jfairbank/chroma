describe Chroma::Color do
  context 'with serializers' do
    let(:green)       { 'green'.paint }
    let(:blue)        { 'rgba(0, 0, 255, 0.5)'.paint }
    let(:transparent) { 'rgba(0, 0, 0, 0)'.paint }

    describe '#to_hsv' do
      it 'returns the hsv string' do
        expect(green.to_hsv).to eq('hsv(120, 100%, 50%)')
        expect(blue.to_hsv).to  eq('hsva(240, 100%, 100%, 0.5)')
      end
    end

    describe '#to_hsl' do
      it 'returns the hsl string' do
        expect(green.to_hsl).to eq('hsl(120, 100%, 25%)')
        expect(blue.to_hsl).to  eq('hsla(240, 100%, 50%, 0.5)')
      end
    end

    describe '#to_hex' do
      context 'with allow_3 set to false' do
        it 'returns the hex string' do
          expect(green.to_hex).to eq('#008000')
          expect(blue.to_hex).to  eq('#0000ff')
        end
      end

      context 'with allow_3 set to true' do
        it 'returns the hex string' do
          expect(green.to_hex(true)).to eq('#008000')
          expect(blue.to_hex(true)).to  eq('#00f')
        end
      end
    end

    describe '#to_hex8' do
      it 'returns the hex8 string' do
        expect(green.to_hex8).to eq('#ff008000')
        expect(blue.to_hex8).to  eq('#800000ff')
      end
    end

    describe '#to_rgb' do
      it 'returns the rgb string' do
        expect(green.to_rgb).to eq('rgb(0, 128, 0)')
        expect(blue.to_rgb).to  eq('rgba(0, 0, 255, 0.5)')
      end
    end

    describe '#to_name' do
      context 'with hex_for_unknown set to false' do
        context 'with known named color' do
          context 'when alpha = 1' do
            it 'returns the named color' do
              expect(green.to_name).to eq('green')
            end
          end

          context 'when alpha < 1' do
            it 'returns "<unknown>"' do
              expect(blue.to_name).to eq('<unknown>')
            end
          end
        end

        context 'when alpha = 0' do
          it 'returns "transparent"' do
            expect(transparent.to_name).to eq('transparent')
          end
        end

        context 'with unknown named color' do
          it 'returns "<unknown>"' do
            expect('#123'.paint.to_name).to eq('<unknown>')
          end
        end
      end

      context 'with hex_for_unknown set to true' do
        context 'with known named color' do
          context 'when alpha = 1' do
            it 'returns the named color' do
              expect(green.to_name(true)).to eq('green')
            end
          end

          context 'when alpha < 1' do
            it 'returns the hex string' do
              expect(blue.to_name(true)).to eq('#0000ff')
            end
          end
        end

        context 'when alpha = 0' do
          it 'returns "transparent"' do
            expect(transparent.to_name(true)).to eq('transparent')
          end
        end

        context 'with unknown named color' do
          it 'returns returns the hex string' do
            expect('#123'.paint.to_name(true)).to eq('#112233')
          end
        end
      end
    end

    describe '#to_s' do
      it 'returns the appropriate string according to format' do
        expect('#ff0000'.paint.to_s).to                    eq('#ff0000')
        expect('#f00'.paint.to_s).to                       eq('#f00')
        expect('#80ff0000'.paint.to_s).to                  eq('#80ff0000')
        expect('hsl(120, 100%, 50%)'.paint.to_s).to        eq('hsl(120, 100%, 50%)')
        expect('hsla(120, 100%, 50%, 0.5)'.paint.to_s).to  eq('hsla(120, 100%, 50%, 0.5)')
        expect('hsv(120, 100%, 50%)'.paint.to_s).to        eq('hsv(120, 100%, 50%)')
        expect('hsva(120, 100%, 50%, 0.5)'.paint.to_s).to  eq('hsva(120, 100%, 50%, 0.5)')
        expect('red'.paint.to_s).to                        eq('red')
      end
    end

    describe '#hsv' do
      it 'returns an hsv instance' do
        hsv = green.hsv

        expect(hsv).to be_a(Chroma::ColorModes::Hsv)
        expect(hsv.h).to be_within(0.01).of(120)
        expect(hsv.s).to be_within(0.01).of(1)
        expect(hsv.v).to be_within(0.01).of(0.5)
        expect(hsv.a).to eq(1)
      end
    end

    describe '#hsl' do
      it 'returns an hsl instance' do
        hsl = green.hsl

        expect(hsl).to be_a(Chroma::ColorModes::Hsl)
        expect(hsl.h).to be_within(0.01).of(120)
        expect(hsl.s).to be_within(0.01).of(1)
        expect(hsl.l).to be_within(0.01).of(0.25)
        expect(hsl.a).to eq(1)
      end
    end

    describe '#rgb' do
      it 'returns the underlying @rgb iv' do
        expect(green.rgb).to equal(green.instance_variable_get(:@rgb))
      end
    end
  end
end
