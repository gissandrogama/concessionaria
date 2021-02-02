defmodule Novo do

  defstruct data: nil, valor: nil, vendido: false

  def compra(chassi, data, valor) do
    
    {:ok, "Compra do veículo #{chassi} cadastrada!"}

  end

  def venda(chassi, data, valor) do
    {:ok, "Venda do veículo #{chassi} cadastrada!"}
  end
end
