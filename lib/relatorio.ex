defmodule Relatorio do
  def imprimir(mes, ano, tipo) do
    buscar_comprados(tipo)
    |> Enum.map(&List.first(&1.registros))
    |> buscar_registro_mes(mes, ano)
  end

  def buscar_comprados(tipo) do
    case tipo do
      :novo ->
        Car.carros_novo()
        |> Enum.filter(fn carro ->
          carro.tipo.comprado == true
        end)
      :seminovo ->
        Car.carros_seminovo()
        |> Enum.filter(fn carro ->
          carro.tipo.comprado == true
        end)
    end
  end

  def buscar_registro_mes(registros, mes, ano) do
    registros
    |> Enum.filter(fn registro ->
      registro.data.month == mes && registro.data.year == ano
    end)
  end
end
