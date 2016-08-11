require_relative 'ie/base'

Dir[File.expand_path("ie/{**/**,**}.rb", File.dirname(__FILE__))].each {|file| require file }

module BRDocuments
  module IE

    AVAILABLE_STATES = [
      'AC',
      'AL',
      'AM',
      'AP',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MG',
      'MS',
      'MT',
      'PA',
      'PB',
      'PE',
      'PI',
      'PR',
      'RJ',
      'RN',
      'RO',
      'RR',
      'RS',
      'SE',
      'SP',
      'TO'
    ]


    def self.available_states
      AVAILABLE_STATES
    end

  end
end