# Concessionaria

**TODO: projeto executado no curso de elixir e phoenix da Elxpro**
Esse projeto foi um exercício do modulo 1 curso `ElxPro`. Projeto para fixar a escrita e conceitos do elixir como: manipulação de arquivos, estruturas de dados, criar documentação, criar testes, refatoração de código, ultilizar Enum's de forma eficiente e muitas outras coisas. Além de treinar a prática de TDD.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `concessionaria` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:concessionaria, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/concessionaria](https://hexdocs.pm/concessionaria).

# Informacoes Tecnicas

- ecosistema elixir

## Iniciando localmente

**1.** Clone o projeto:

 * ssh
```sh
$ git git@github.com:gissandrogama/concessionaria.git
```

 * https
```sh
$ git clone https://github.com/gissandrogama/concessionaria.git
```

**2.** Acesse a pasta do projeto:

```sh
$ cd concessionaria
```

**3.** Instale as dependências:

```sh
$ mix deps.get
```

**4.** criar e migrar o banco de dados, e inserir dados do db.json:

```sh
$ iex -S mix
```

# Gerar documentação da aplicação

Para gerar a documentação da aplicação só excutar o comando:
```sh
$ mix docs
```
A documentação ira guiar você de forma certa para utilizar o sistema.

# Breve tutorial

## Gerar arquivos para armazenar os dados
```Elixir
    iex> Concessionaria.start
```

## Cadastrar um veículo

parametros: ano, marca, modelo, cambio, combustivel, cor, portas, chassi, tipo

```Elixir
    iex> Concessionaria.cadastrar_carro "2021", "Fiat", "Argo", ..., :novo
```

## Cadastrar e registrar a compra de um veículo
parametros = chassi, data, valor, tipo
```Elixir
    iex> Concessionaria.comprar("ABCD123", data, 15000, :novo)
```

## Cadastrar e registrar a venda de um veículo
parametros = chassi, data, valor, tipo
```Elixir
    iex> Concessionaria.vender("ABCD123", data, 15000, :novo)
```

## Imprimir relatório de compras e vendas
```Elixir
    iex> Concessionaria.imprimir_relatorio(01, 2021)
```
