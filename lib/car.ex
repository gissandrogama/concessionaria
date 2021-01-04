defmodule Car do
  @enforce_keys [:ano, :marca, :modelo, :chassi]
  defstruct [:ano, :marca, :modelo, :cambio, :combustivel, :cor, :portas, :chassi, :tipo]

  @car %{:novo => "novo.txt", :seminovo => "semi.txt"}

  def buscar_carro(chassi, key \\ :all) do
    buscar(chassi, key)
  end

  defp buscar(chassi, :novo), do: filter(carros_novo(), chassi)
  defp buscar(chassi, :seminovo), do: filter(carros_seminovo(), chassi)
  defp buscar(chassi, :all), do: filter(carros(), chassi)
  defp filter(lista, chassi), do: Enum.find(lista, &(&1.chassi == chassi))

  def carros(), do: read(:novo) ++ read(:seminovo)
  def carros_novo(), do: read(:novo)
  def carros_seminovo(), do: read(:seminovo)

  def cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, tipo \\ :novo) do
    case buscar_carro(chassi) do
      nil ->
        (read(tipo) ++
           [
             %__MODULE__{
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
           ])
        |> :erlang.term_to_binary()
        |> write(tipo)

        {:ok, "Veículo com chassi #{chassi}, cadastrado com sucesso!"}

      _carro ->
        {:error, "Veículo já cadastrado"}
    end
  end

  defp write(lista_carro, tipo) do
    File.write!(@car[tipo], lista_carro)
  end

  def deletar(chassi) do
    # veiculo = buscar_carro(chassi)
    {:ok, "Veículo com o chassi: #{chassi} deletado!"}

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
