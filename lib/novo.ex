defmodule Novo do
  defstruct comprado: false, vendido: false

  def compra(chassi, data, valor) do
    {carro, tipo} = carro_tipo(chassi)
    tipo = %__MODULE__{tipo | comprado: true}

    %Car{carro | tipo: tipo}
    |> Caixa.registro(data, valor)

    {:ok, "Compra do veículo #{carro.chassi} cadastrada!"}
  end

  def venda(chassi, data, valor) do
    {carro, tipo} = carro_tipo(chassi)
    tipo = %__MODULE__{tipo | vendido: true}

    %Car{carro | tipo: tipo}
    |> Caixa.registro(data, valor)

    {:ok, "Venda do veículo #{carro.chassi} cadastrada!"}
  end

  defp carro_tipo(chassi) do
    carro = Car.buscar_carro(chassi, :novo)
    tipo = carro.tipo

    {carro, tipo}
  end
end
