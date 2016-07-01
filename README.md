# Brazilian Documents

Esta gem tem como proposta ser um repositório com os principais validadores de documentos **oficiais do Brasil**.
Atualmente existem **validadores**(e não geradores) para:

* CPF
* CNPJ
* RG (Carteira de Identidade) [TODO]
* Título de Eleitor [TODO]

Essa gem é construída em cima da gem [**digit_checksum**](https://github.com/fidelisrafael/digit_checksum), que torna todo o processo muito mais simples e padronizado!


---

## Instalação

Adicione no seu Gemfile:

```ruby
gem 'brazilian_documents'
```

E execute:

    $ bundle

Ou então instale separadamente (e globalmente) com:

    $ gem install brazilian_documents

---

## Como usar 

Entenda que a proposta dessa gem não é gerar número de documentos, somente validar! A ideia é ser pequena e portátil.

### API

#### Observação:

 **TODOS** os documentos tem a mesma **assinatura e interface** de API, sendo assim para manusear tipos diferentes de documento, somente altere o nome da classe para o tipo de documento desejado, que podem ser:

##### `BRDocuments::CPF`
##### `BRDocuments::CNPJ`

Nos exemplos abaixo, a classe `BRDocuments::CPF` será utilizada para detalhar a **API comum a todos os documentos**, porém lembre-se que você pode usar **qualquer uma** das classes acima listada.

---

Você pode usar essa biblioteca para:


#### Validar documento

```ruby
require 'br_documents'

BRDocuments::CPF.valid?(number) # verifica se um CPF é valido
BRDocuments::CPF.invalid?(number) # verifica se um CPF é inválido

# Ex: 

BRDocuments::CPF.valid?("481.455.512-18") # true
BRDocuments::CPF.valid?("481.455.512-20") # false
BRDocuments::CPF.invalid?(48145551220) # true

```

#### Calcular dígitos verificadores (DV)

```ruby
require 'br_documents'

# Calcula os dígitos verificadores de um CPF(number deve ser composto de 9 dígitos
BRDocuments::CPF.calculate_verify_digits(number)

# Ex:

# Número válido
BRDocuments::CPF.calculate_verify_digits("481.455.512") # [1, 8]

# Número inválido
BRDocuments::CPF.calculate_verify_digits("481.455.51") # []
```

#### Normalizar e formatar documento

```ruby
require 'br_documents'

BRDocuments::CPF.pretty_formatted(number) # (XXX.XXX.XXX-XX)

# Retorna CPF normalizado como Array ([X,X,X,X,X,X,X,X,X,X,X,X])
BRDocuments::CPF.normalize_document_number(number)

# Retorna CPF normalizado como String (XXXXXXXXXXXX)
BRDocuments::CPF.normalize_document_number_to_s(number)

# Ex:

BRDocuments::CPF.pretty_formatted("48145551218") # 481.455.512-18

# Normaliza número e retorna como Array: [4, 8, 1, 4, 5, 5, 5, 1, 2, 1, 8]
BRDocuments::CPF.normalize_document_number("481.455.512-18")

BRDocuments::CPF.normalize_document_number_to_s("481.455.512-18") # "48145551218"

```
---

## Desenvolvimento

Execute  `bin/setup` para instalar as dependências to install dependencies. Em seguida execute `rake spec` para executar todos os testes. Você pode também executar `bin/console` para iniciar um shell interativo para seus experimentos

Para instalar essa gem localmente em sua máquina, execute `bundle exec rake install`. 

---

## Contribua!

Você pode enviar bugs reports, pull requests e abrir issues no GitHub: https://github.com/fidelisrafael/br_documents. 
Para entender a arquitetura e padrão de cada arquivo, veja a pasta `lib/br_documents/documents` e leia a documentação da gem [**digit_checksum**](https://github.com/fidelisrafael/digit_checksum).  
Pense em cada documento como um **adapter** criado em cima da API da Gem `DigitCheckSum`.

Obrigado!

---

## Licença

Essa biblioteca está disponível como projeto open source sob os termos da [Licença MIT](http://opensource.org/licenses/MIT).

