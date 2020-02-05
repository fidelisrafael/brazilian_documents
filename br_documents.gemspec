# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'br_documents/version'

Gem::Specification.new do |spec|
  spec.name          = "brazilian_documents"
  spec.version       = BRDocuments::VERSION
  spec.authors       = ["Rafael Fidelis"]
  spec.email         = ["rafa_fidelis@yahoo.com.br"]

  spec.summary       = %q{Coleção de validadores para documentos brasileiros}
  spec.description   = %q{Esta gem implementa vários validadores de documentos oficiais brasileiros, como CPF, CNPJ, Inscrição estadual, RG e Título de Eleitor}
  spec.homepage      = "https://github.com/fidelisrafael/brazilian_documents"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'digit_checksum', '~> 0.2.3'
  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
