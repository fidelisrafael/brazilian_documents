require 'spec_helper'

describe BRDocuments::IE do
  describe '.availabe_states' do

    it 'has 27 elements' do
      expect(BRDocuments::IE::available_states.count).to eq(27)
    end

    it 'includes all brazilian states' do
      expect(BRDocuments::IE::available_states)
        .to  include("AC")
        .and include("AL")
        .and include("AM")
        .and include("AP")
        .and include("BA")
        .and include("CE")
        .and include("DF")
        .and include("ES")
        .and include("GO")
        .and include("MA")
        .and include("MG")
        .and include("MS")
        .and include("MT")
        .and include("PA")
        .and include("PB")
        .and include("PE")
        .and include("PI")
        .and include("PR")
        .and include("RJ")
        .and include("RN")
        .and include("RO")
        .and include("RR")
        .and include("RS")
        .and include("SC")
        .and include("SE")
        .and include("SP")
        .and include("TO")
    end
  end
end
