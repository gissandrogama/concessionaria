defmodule Caixa do
  defstruct data: nil, valor: nil

  def registro(carro, data, valor) do
    carro_atualizado = %Car{
      carro
      | registros: carro.registros ++ [%__MODULE__{data: data, valor: valor}]
    }

    Car.atualizar(carro.chassi, carro_atualizado)
  end
end
