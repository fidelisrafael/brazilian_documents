# Brazilian Documents

Esta gem tem como proposta ser um repositório com os principais validadores de documentos **oficiais do Brasil**.
Atualmente existem **validadores e geradores** para os seguintes documentos:

* CPF
* CNPJ
* Inscrição Estadual (dos 27 estados federativos do Brasil)
* RG (Carteira de Identidade) [TODO]
* Título de Eleitor [TODO]

Essa gem é construída em cima da gem [**digit_checksum**](https://github.com/fidelisrafael/digit_checksum), que torna todo o processo muito mais simples e padronizado!

---

## Instalação

Adicione no seu Gemfile:

```ruby
gem 'brazilian_documents', '~> 0.1.2'
```

E execute:

    $ bundle

Ou então instale separadamente (e globalmente) com:

    $ gem install brazilian_documents

---

## Como usar

### API

#### Observação:

 **TODOS** os documentos tem a mesma **assinatura e interface** de API, sendo assim para manusear tipos diferentes de documento, somente altere o nome da classe para o tipo de documento desejado, que podem ser:

##### `BRDocuments::CPF`
##### `BRDocuments::CNPJ`

Nos exemplos abaixo, a classe `BRDocuments::CPF` será utilizada para detalhar a **API comum a todos os documentos**, porém lembre-se que você pode usar **qualquer uma** das classes acima listada.

---

Você pode usar essa biblioteca para:

#### Gerar números [falsos]

```ruby
require 'br_documents'

BRDocuments::CPF.generate # "585.483.998-99"
BRDocuments::CPF.generate(false) # "00670564826" -- sem formatação

BRDocuments::CNPJ.generate # "53.091.177/2847-09"

```

#### Validar documento

```ruby
require 'br_documents'

BRDocuments::CPF.valid?(number) # verifica se um CPF é valido
BRDocuments::CPF.invalid?(number) # verifica se um CPF é inválido

### Exemplos:

BRDocuments::CPF.valid?("481.455.512-18") # true
BRDocuments::CPF.valid?("481.455.512-20") # false
BRDocuments::CPF.invalid?(48145551220) # true

```

#### Calcular dígitos verificadores (DV)

```ruby
require 'br_documents'

# Calcula os dígitos verificadores de um CPF(number deve ser composto de 9 dígitos
BRDocuments::CPF.calculate_verify_digits(number)

### Exemplos:

# Número válido
BRDocuments::CPF.calculate_verify_digits("481.455.512-18")
BRDocuments::CPF.calculate_verify_digits("481.455.512") # [1, 8]

# Número inválido
BRDocuments::CPF.calculate_verify_digits("481.455.51") # []
```

#### Normalizar e formatar documento

```ruby
require 'br_documents'

BRDocuments::CPF.pretty(number) # (XXX.XXX.XXX-XX)

# Retorna CPF normalizado como Array ([X,X,X,X,X,X,X,X,X,X,X,X])
BRDocuments::CPF.normalize(number)

# Retorna CPF normalizado como String (XXXXXXXXXXXX)
BRDocuments::CPF.strip(number)

### Exemplos:

# Retorna CPF formatado
BRDocuments::CPF.pretty("48145551218") # 481.455.512-18

# Normaliza número e retorna como Array: [4, 8, 1, 4, 5, 5, 5, 1, 2, 1, 8]
BRDocuments::CPF.normalize("481.455.512-18")

BRDocuments::CPF.strip("481.455.512-18") # "48145551218"
```

---

## Inscrições Estaduais

É possível validar e gerar números de inscrições estaduais utilizando essa biblioteca, sendo que **SEMPRE** será respeitado todos os critérios para a definição de uma Inscrição Estadual, como por exemplo os dígitos fixos adicionados ao inicio de cada número de documento, que varia conforme o estado. (alguns estados não possuem dígitos fixos).

Além disso, alguns estados possuem **mais de 1 padrão de inscrição estadual válido** (PQ BRASIL???), que podem ser definidos como **atual** e **legado**, esses estados são:

<br />

* **BA** - Possui **4 formatos** de números válidos
  * 8 dígitos calculados com modulo 10
  * 8 dígitos calculados com modulo 11
  * 9 dígitos calculados com modulo 10
  * 9 dígitos calculados com modulo 11

* **PE** - Possui **2 formatos** de números válidos
  * Legado (14 dígitos)
  * Atual (9 dígitos)

* **R** - Possui **2 formatos** de números válidos
  * Legado (9 dígitos)
  * Atual (14 dígitos)

* **SP** - Possui **2 formatos** de números válidos
  * Industrial (12 dígitos), com dígitos verificadores no "meio" do número
  * Rural (12 dígitos), com dígitos verificadores no "meio" do número

---

### API Inscrições Estaduais

### Gerar números

```ruby
# BRDocuments::IE::{ESTADO}.generate
# {ESTADO} deve ser a sigla de cada unidade federativa do Brasil
# Para consultar todas as unidades federativas:

BRDocuments::IE.available_states
=> [
  "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO",
  "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR",
  "RJ", "RN", "RO", "RR", "RS", "SE", "SP", "TO"
]

## Ex

BRDocuments::IE::MG.generate # "484322874.82-21"

BRDocuments::IE::DF.generate # "07.372.652.746-25"
```

Os estados com **mais de 1 tipo de padrão válido** possuem opções para gerar cada um dos formatos, veja:


#### Bahia (BA)

```ruby
# BA atual - 9 dígitos - modulo 10
# SEGUNDO dígito da I.E: 0,1,2,3,4,5,8
BRDocuments::IE::BA.generate
# => "031.112.264"

# BA Atual - 9 dígitos - modulo 11
# SEGUNDO dígito da I.E: 6, 7 ou 9
BRDocuments::IE::BA.generate(true, 9, 11)
=> "273.854.609"

# BA legado - 8 dígitos - modulo 10
# PRIMEIRO dígito da I.E: 0,1,2,3,4,5,8
BRDocuments::IE::BA.generate(true, 8, 10)
=> "476.354.65"

# BA legado - 8 dígitos - modulo 11
# PRIMEIRO dígito da I.E:  6, 7 ou 9
BRDocuments::IE::BA.generate(true, 8, 11)
=> "612.733.29"
```

#### Pernambuco (PE)

```ruby
# Padrão atual: 6 dígitos + 2 dígitos verificadores
BRDocuments::IE::PE.generate
=> "6920752-67"

# Padrão antigo: 13 dígitos + 1 dígito verificador
BRDocuments::IE::PE.generate(true, true)
=> "01.3.667.8339833-8"

# Checar se número é do padrão legado
BRDocuments::IE::PE.legacy?("01.3.667.8339833-8") # true
BRDocuments::IE::PE.legacy?("6920752-67") # false
```

#### Roraima (RO)

```ruby
# Padrão atual: 13 dígitos + 1 dígito verificador
BRDocuments::IE::RO.generate
=> "0000000081197-1"

# Padrão legado: 3 dígitos(município) + 5 dígitos(inscrição) + 1 dígito verificador
BRDocuments::IE::RO.generate(true, true)
=> "557.88373-5"

# Para converter um número do padrão legado para o padrão atual:
BRDocuments::IE::RO.convert_legacy("557.88373-5")
=> "0000000088373-5"

# Checar se número é do padrão legado
BRDocuments::IE::RO.legacy?("557.88373-5") # true
BRDocuments::IE::RO.legacy?("0000000081197-1") # false
```

#### São Paulo (SP)

O estado de São Paulo não possui padrões **legados**, somente o padrão **Industriais** e de **Produtor Rural**, veja:

```ruby
# Padrão atual com 10 dígitos + 2 dígitos verificadores
# OBS: Os dígitos verificadores ficam nas posições 8 e 10
# E não convenialmente no final do documento
BRDocuments::IE::SP.generate
=> "593.024.470.190"

# Padrão de Produtor Rural
# P + 11 dígitos + 1 dígito verificador
# OBS: O digíto verificador fica na oitava posição do número
BRDocuments::IE::SP.generate(true, true)
=> "P-54855620.8/324"


# Checar se número é do padrão legado
BRDocuments::IE::SP.rural?("P-54855620.8/324") # true
BRDocuments::IE::SP.rural?("593.024.470.190") # false
```

---

### Validar Inscrições Estaduais

```ruby
BRDocuments::IE::{ESTADO}.generate
# {ESTADO} deve ser a sigla de cada unidade federativa do Brasil

## Ex:
BRDocuments::IE::MG.valid?('062013766.01-45') # true
BRDocuments::IE::SP.valid?('102.614.327.119') # true
BRDocuments::IE::RS.valid?('029/0487447') # true
```

---

### Calcular dígitos verificadores

```ruby
# número com dígitos verificadores já inclusos
BRDocuments::IE::SP.calculate_verify_digits('110.042.490.114') # => [0, 4]

# Número sem os dígitos verificadores
BRDocuments::IE::SP.calculate_verify_digits('110.042.49.11') # => [0, 4]

# É possível também calcular e adicionar os dígitos verificadores nas posições corretas utilizando:
# Na IE de SP os dígitos verificadores ficam nas posições 8 e 11.
# Evite inserir os dígitos verificadores manualmente no final do documento, utilize a API.
BRDocuments::IE::SP.append_verify_digits!('110.042.49.11') # => "110042490114"

BRDocuments::IE::PA.calculate_verify_digits("15.069.665") # => [5]
```
---

### Formatar Inscrições Estaduais

Cada estado possui um padrão diferente de formatação das IE, utilizando a API dessa gem você não precisa se preocupar com isso:

```ruby
BRDocuments::IE::SP.pretty('P011004243002') # => 'P-01100424.3/002'

BRDocuments::IE::PB.pretty('160158230') # => "16.015.823-0"

BRDocuments::IE::DF.pretty('0730000100109') # => "07.300.001.001-09"

# Para remover a formatação:
BRDocuments::IE::DF.stripped("07.300.001.001-09") # => "0730000100109"
```

---

### PORO - Plain Old Ruby Objects

Todos a API demonstrada nessa documentação (geralmente metodos de classe) são **apenas delegações de métodos para a instância de um objeto Ruby**,  você pode trabalhar diretamente com os objetos da seguinte maneira:

```ruby
# A API é a mesma para TODOS os objetos, ex:

# object = BRDocuments::IE::DF.new("07.300.001.001-09")
# object = BRDocuments::IE::MG.new("07.300.001.001-09")
# object = BRDocuments::CNPJ.new("53.091.177/2847-09")

object = BRDocuments::CPF.new('481.455.512-18')

object.valid? # true

# Tenta obter os digitos verificadores baseado nas posições
object.current_verify_digits # [1,8]

# Remove os digitos verificadores do objeto
object.remove_verify_digits! # [1,8]

# Tenta obter os digitos verificadores baseado nas posições
object.current_verify_digits # []

object.number # object.to_s => 481455512

# Somente calcula, não adiciona ao objeto
object.calculate_verify_digits # [1,8]

# Utiliza o método `calculate_verify_digits` e adiciona os dígitos nas posições corretas
object.append_verify_digits! # "48145551218"

object.pretty # "481.455.512-18"

object.normalize
# => [4, 8, 1, 4, 5, 5, 5, 1, 2, 1, 8]

object.strip # 48145551218

object.size # 11

object.root_digits_count # 9

object.verify_digits_count # 2

# root_digits_count + verify_digits_count
object.full_size # 11

object.verify_digits_positions # [9,10]
```


---

## Ajuda requirida!

Olá, que bom que você chegou até aqui! Para o desenvolvimento dessa gem eu me guiei pelo [**péssimo guia**](www.sintegra.gov.br/insc_est.html) do Sintegra, que esquece de citar vários pontos importantes na definição dos padrões de cada estado, muito deles só fui saber enquanto eu testava, pois validei várias inscrições estaduais das maiores empresas de cada estado.
Por isso, se você tiver conhecimento dos padrões(ex: dígitos iniciais fixos) do seu estado - ou dos demais - por favor, dê uma olhada no código da gem e ajude a tornar a validação e geração mais exata! Obrigado!

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

Essa biblioteca está disponível como projeto open source sob os termos da [Licença MIT](http://opensource.org/licenses/MIT.
