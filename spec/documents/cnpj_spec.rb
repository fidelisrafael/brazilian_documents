require 'spec_helper'

describe BRDocuments::CNPJ do
  it 'normalize document number' do
    document_number = '09037584000144'
    expected_normalized = [0,9,0,3,7,5,8,4,0,0,0,1,4,4]

    normalized_document_number = described_class.normalize(document_number)

    expect(normalized_document_number).to eq(expected_normalized)
    expect(normalized_document_number).to be_a(Array)
  end

  it 'clear the document number formatting' do
    document_number = '57.451.163/0001-08'
    expected_stripped = '57451163000108'

    stripped_document_number = described_class.strip(document_number)

    expect(stripped_document_number).to eq(expected_stripped)
    expect(stripped_document_number).to be_a(String)
  end

  it 'pretty format the document number' do
    document_number = 57451163000108
    expected_formatted = '57.451.163/0001-08'

    formatted_document_number = described_class.pretty(document_number)

    expect(formatted_document_number).to eq(expected_formatted)
    expect(formatted_document_number).to match(described_class.get_format_regexp)
  end

  it 'calculates all verify digits for document' do
    document_number = '57.451.163/0001'

    verify_digits = described_class.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([0, 8])
  end

  it 'calculates all verify digits for normalized document' do
    document_number = described_class.normalize('57.451.163/0001')

    verify_digits = described_class.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([0, 8])
  end

  it 'returns only root of document number' do
    document_number = '57.451.163/0001-08'
    root_document_number = '574511630001'
    root_document_number_arry = [5,7,4,5,1,1,6,3,0,0,0,1]

    root_string = described_class.root_number_to_s(document_number)
    root_array = described_class.root_number(document_number)

    expect(root_string).to eq(root_document_number)
    expect(root_string).to be_a(String)
    expect(root_array).to eq(root_document_number_arry)
    expect(root_array).to be_a(Array)
  end

  it 'correctly validate document number' do
    document_number = '57.451.163/0001-08'

    expect(described_class.valid?(document_number)).to be true
    expect(described_class.invalid?(document_number)).to be false
  end

  it 'correctly mark document number as invalid' do
    document_number = '57.451.163/0001-10'

    expect(described_class.valid?(document_number)).to be false
    expect(described_class.invalid?(document_number)).to be true
  end

  it 'consider nil document_number as invalid document' do
    expect(described_class.valid?(nil)).to eq(false)
  end

  it 'consider blank document_number as invalid document' do
    expect(described_class.valid?('')).to eq(false)
  end

  it 'generate valid documents numbers' do
    10.times do
      generated_doc = described_class.generate

      expect(described_class.valid?(generated_doc)).to eq(true)
    end
  end
end
