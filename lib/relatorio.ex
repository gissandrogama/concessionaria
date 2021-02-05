defmodule Relatorio do
  def imprimir(mes, ano) do
    Car.carros_novo()
    |> Enum.map(fn carro ->
      Enum.filter(carro.registros, fn registro ->
        registro.data.month == mes && registro.data.year == ano
      end)
    end)
  end
end
