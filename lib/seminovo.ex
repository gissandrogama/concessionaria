defmodule Seminovo do
  defstruct comprado: false, vendido: false

  def compra(chassi, data, valor) do
    {carro, tipo} = carro_tipo(chassi)
    tipo = %__MODULE__{tipo | comprado: true}

    %Car{carro | tipo: tipo}
    |> Caixa.registro(data, valor)

    {:ok, "Compra do seminovo #{carro.chassi} cadastrada!"}
  end

  def venda(chassi, data, valor) do
    {carro, tipo} = carro_tipo(chassi)
    tipo = %__MODULE__{tipo | vendido: true}

    %Car{carro | tipo: tipo}
    |> Caixa.registro(data, valor)

    {:ok, "Venda do seminovo #{carro.chassi} cadastrada!"}
  end

  def relatorio(mes, ano) do
    Relatorio.imprimir(mes, ano, :seminovo)
  end

  defp carro_tipo(chassi) do
    carro = Car.buscar_carro(chassi, :seminovo)
    tipo = carro.tipo

    {carro, tipo}
  end
end
