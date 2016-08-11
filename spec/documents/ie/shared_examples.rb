RSpec.shared_examples "IE basic specs" do
  it 'must generate root numbers with fixed numbers' do

    next if [BRDocuments::IE::RJ, BRDocuments::IE::BA].member?(described_class)

    number = described_class.generate_root_numbers # without formatting

    initial_pos = described_class.fixed_digits_positions
    fixed_numbers = described_class.fixed_digits

    expect(number.slice(initial_pos, fixed_numbers.size)).to eq(fixed_numbers)
  end

  it 'generate documents must have valid fixed numbers' do
    document = described_class.new(described_class.generate)

    expect(document.valid_fixed_digits?).to be_truthy
  end

  it 'must generate valid IE' do
    10.times {
      expect(described_class.valid?(described_class.generate)).to be_truthy
    }
  end

  it 'pretty formats an IE number' do
    @format_examples.each do |stripped, pretty|
      pretty = pretty[0] if pretty.is_a?(Array)

      expect(described_class.pretty(stripped)).to eq(pretty)
    end
  end

  it 'must generate new numbers including initial fixed numbers' do
    next if [BRDocuments::IE::RJ, BRDocuments::IE::BA].member?(described_class)

    10.times {
      number = described_class.generate

      expect(number).to match(/\A#{described_class.fixed_digits.join}/)
    }
  end

  it 'remove an IE number formatting' do
    @format_examples.each do |stripped, pretty|
      pretty, stripped = *pretty if pretty.is_a?(Array)

      expect(described_class.strip(pretty)).to eq(stripped)
    end
  end

  it 'must validate correctly valid IE numbers' do
    @valid_numbers.each do |number|
      expect(described_class.valid?(number)).to be_truthy
      expect(described_class.new(number)).to be_valid
    end
  end

  it 'is invalid with wrong digits number' do
    @invalid_numbers.each do |number|
      expect(described_class.invalid?(number)).to be_truthy
      expect(described_class.new(number)).to be_invalid
    end

  end

  it 'must calculate verify digits' do
    @valid_verify_digits.each do |verify_digits, numbers|
      numbers.each do |number|
        expect(described_class.calculate_verify_digits(number)).to eq(verify_digits)

        object = described_class.new(number)

        object.append_verify_digits!
        expect(object.current_verify_digits).to eq(verify_digits)

        expect(object.remove_verify_digits!).to eq(verify_digits)

        object.append_verify_digits!

        expect(object.current_verify_digits).to eq(verify_digits)
        expect(object.calculate_verify_digits).to eq(verify_digits)
      end
    end
  end

  it 'must validate a list of valid IE' do
    @valid_existent_numbers.each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end