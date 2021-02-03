defmodule Car do
  @moduledoc """
    Modulo de `car`  para cadastro de tipos de veículos como `novo` e `semi-novo`

    A função mais ultilizada e a função `cadastrar/9`
  """
  @enforce_keys [:ano, :marca, :modelo, :chassi]
  defstruct [
    :ano,
    :marca,
    :modelo,
    :cambio,
    :combustivel,
    :cor,
    :portas,
    :chassi,
    :tipo,
    registros: []
  ]

  @car %{:novo => "novo.txt", :seminovo => "semi.txt"}

  @doc """
  Função que lista vaículos `novos`, `semi-novos` e também todos os veículo

  ## Parametros da função

  - chassi: numero que foi cadastrado para o assinante
  - key: a chave que é um atom com o tipo de cliente: `:novo`, `:seminovo` ou `:all`

  ## Informações adicionais

  - Caso o parametro de tipo de veículo não for passo, será listado uma lista todos os tipos de clientes

  ## Exemplo

      iex> Car.cadastrar("2020", "Fiat", "Palio", "automatico", "gasolina", "preta", 4, "ABCD", :novo)
      iex> Car.buscar_carro("ABCD", :novo)
      %Car{
          ano: "2020",
          marca: "Fiat",
          modelo: "Palio",
          cambio: "automatico",
          combustivel: "gasolina",
          cor: "preta",
          portas: 4,
          chassi: "ABCD",
          tipo: %Novo{comprado: false, vendido: false}
          }

      iex> Car.cadastrar("2019", "Fiat", "Palio", "automatico", "gasolina", "preta", 2, "ABCDE", :seminovo)
      iex> Car.buscar_carro("ABCDE", :seminovo)
      %Car{
          ano: "2019",
          marca: "Fiat",
          modelo: "Palio",
          cambio: "automatico",
          combustivel: "gasolina",
          cor: "preta",chassi
          tipo: %Seminovo{comprado: false, vendido: false}
          }
  """
  def buscar_carro(chassi, key \\ :all) do
    buscar(chassi, key)
  end

  defp buscar(chassi, :novo), do: filter(carros_novo(), chassi)
  defp buscar(chassi, :seminovo), do: filter(carros_seminovo(), chassi)
  defp buscar(chassi, :all), do: filter(carros(), chassi)
  defp filter(lista, chassi), do: Enum.find(lista, &(&1.chassi == chassi))

  @doc """
  Função com aridade `0` que lista todos os veículos, tanto novos como seminovos

  ## Exemplo


      iex> Car.cadastrar("2020", "Fiat", "Palio", "automatico", "gasolina", "preta", 4, "ABCD", :novo)
      iex> Car.cadastrar("2019", "Fiat", "Palio", "automatico", "gasolina", "preta", 2, "ABCDE", :seminovo)
      iex> Car.carros()
      [
         %Car{
          ano: "2020",
          marca: "Fiat",
          modelo: "Palio",
          cambio: "automatico",
          combustivel: "gasolina",
          cor: "preta",
          portas: 4,
          chassi: "ABCD",
          tipo: %Novo{comprado: false, vendido: false}
          },
         %Car{
          ano: "2019",
          marca: "Fiat",
          modelo: "Palio",
          cambio: "automatico",
          combustivel: "gasolina",
          cor: "preta",
          portas: 2,
          chassi: "ABCDE",
          tipo: %Seminovo{comprado: false, vendido: false}
          }
      ]
  """
  def carros(), do: read(:novo) ++ read(:seminovo)

  @doc """
  Função com aridade `0` que lista todos os veículos novos

  ## Exemplo


      iex> Car.cadastrar("2020", "Fiat", "Palio", "automatico", "gasolina", "preta", 4, "ABCD", :novo)
      iex> Car.cadastrar("2019", "Fiat", "Palio", "automatico", "gasolina", "preta", 2, "ABCDE", :seminovo)
      iex> Car.carros_novo()
      [
        %Car{
          ano: "2020",
          marca: "Fiat",
          modelo: "Palio",
          cambio: "automatico",
          combustivel: "gasolina",
          cor: "preta",
          portas: 4,
          chassi: "ABCD",
          tipo: %Novo{comprado: false, vendido: false}
          }
      ]
  """
  def carros_novo(), do: read(:novo)

  @doc """
  Função com aridade `0` que lista todos os veículos seminovos

  ## Exemplo


      iex> Car.cadastrar("2020", "Fiat", "Palio", "automatico", "gasolina", "preta", 4, "ABCD", :novo)
      iex> Car.cadastrar("2019", "Fiat", "Palio", "automatico", "gasolina", "preta", 2, "ABCDE", :seminovo)
      iex> Car.carros_seminovo()
      [
        %Car{
          ano: "2019",
          marca: "Fiat",
          modelo: "Palio",
          cambio: "automatico",
          combustivel: "gasolina",
          cor: "preta",
          portas: 2,
          chassi: "ABCDE",
          tipo: %Seminovo{comprado: false, vendido: false}
          }
      ]
  """
  def carros_seminovo(), do: read(:seminovo)

  @doc """
  Função para cadastrar vaículos `novo` ou `seminovo`

  ## Parametos da função

  - ano: ano de fabricação do veículo
  - marca: qual fabricante do veículo, exemplo: Ford
  - modelo: modelo do veículo, exemplo: Fiesta
  - cambio: tipo de cambio do veículo automatico ou manual
  - combustivel: tipo de combustivel ultilizado pelo veículo
  - cor: cor que predomina no veículo
  - portas: quantidade de portatas
  - chassi: indentificação do veículo chassi
  - tipo: `veículo` novo ou `seminovo`

  ## informações adicionais

  - Caso o chassi já exista, será retornado um erro.

  ## Exemplo


      iex> Car.cadastrar("2019", "Fiat", "Palio", "automatico", "gasolina", "preta", 2, "ABCDE", :seminovo)
      {:ok, "Veículo com chassi ABCDE, cadastrado com sucesso!"}
  """
  def cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, :novo),
    do: cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, %Novo{})

  def cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, :seminovo),
    do: cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, %Seminovo{})

  def cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, tipo) do
    case buscar_carro(chassi) do
      nil ->
        carro = %__MODULE__{
          ano: ano,
          marca: marca,
          modelo: modelo,
          cambio: cambio,
          combustivel: combustivel,
          cor: cor,
          portas: portas,
          chassi: chassi,
          tipo: tipo
        }

        (read(valida_carro(carro)) ++ [carro])
        |> :erlang.term_to_binary()
        |> write(valida_carro(carro))

        {:ok, "Veículo com chassi #{chassi}, cadastrado com sucesso!"}

      _carro ->
        {:error, "Veículo já cadastrado"}
    end
  end

  def atualizar(chassi, carro) do
    {veiculo_antigo, nova_lista} = deletar_veículo(chassi)

    case carro.tipo.__struct__ == veiculo_antigo.tipo.__struct__ do
      true ->
        (nova_lista ++ [carro])
        |> :erlang.term_to_binary()
        |> write(valida_carro(carro))

      false ->
        {:error, "Veículo não pode ter o tipo alterado."}
    end
  end

  defp valida_carro(carro) do
    case carro.tipo.__struct__ == Novo do
      true -> :novo
      false -> :seminovo
    end
  end

  defp write(lista_carro, tipo) do
    File.write!(@car[tipo], lista_carro)
  end

  def deletar(chassi) do
    {veiculo, nova_lista} = deletar_veículo(chassi)

    nova_lista
    |> :erlang.term_to_binary()
    |> write(veiculo.tipo)

    {nova_lista, "Veículo com o chassi: #{veiculo.chassi} deletado!"}
  end

  def deletar_veículo(chassi) do
    veiculo = buscar_carro(chassi)

    nova_lista =
      read(valida_carro(veiculo))
      |> List.delete(veiculo)

    {veiculo, nova_lista}
  end

  def read(tipo) do
    case File.read(@car[tipo]) do
      {:ok, carros} ->
        carros
        |> :erlang.binary_to_term()

      {:error, :enoent} ->
        {:error, "Arquivo inválido"}
    end
  end
end
