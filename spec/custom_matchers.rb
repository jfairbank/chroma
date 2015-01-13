RSpec::Matchers.define :generate_palette do |expected|
  expected.map!(&:paint)

  match do |actual|
    actual == expected
  end
end
