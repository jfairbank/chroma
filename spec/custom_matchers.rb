RSpec::Matchers.define :generate_palette do |expected|
  expected.map!(&:paint)

  match do |actual|
    actual == expected
  end
end

RSpec::Matchers.define :have_format do |expected|
  match do |actual|
    actual.format == expected
  end
end

RSpec::Matchers.define :be_dark do
  match { |value| value.dark? }
end

RSpec::Matchers.define :be_light do
  match { |value| value.light? }
end
