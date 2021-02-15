defmodule Relatorio do
  def imprimir(mes, ano, tipo) do
    comprados = buscar_comprados(tipo, mes, ano)
    vendidos = buscar_vendidos(tipo, mes, ano)

    {comprados, vendidos}
  end

  def buscar_comprados(tipo, mes, ano) do
    case tipo do
      :novo ->
        Car.carros_novo()
        |> Enum.filter(fn carro ->
          carro.tipo.comprado == true && Enum.find(carro.registros, &(&1.data.month == mes)) &&
            Enum.find(carro.registros, &(&1.data.year == ano))
        end)

      :seminovo ->
        Car.carros_seminovo()
        |> Enum.filter(fn carro ->
          carro.tipo.comprado == true && Enum.find(carro.registros, &(&1.data.month == mes)) &&
            Enum.find(carro.registros, &(&1.data.year == ano))
        end)
    end
  end

  def buscar_vendidos(tipo, mes, ano) do
    case tipo do
      :novo ->
        Car.carros_novo()
        |> Enum.filter(fn carro ->
          carro.tipo.vendido == true && Enum.find(carro.registros, &(&1.data.month == mes)) &&
            Enum.find(carro.registros, &(&1.data.year == ano))
        end)

      :seminovo ->
        Car.carros_seminovo()
        |> Enum.filter(fn carro ->
          carro.tipo.vendido == true && Enum.find(carro.registros, &(&1.data.month == mes)) &&
            Enum.find(carro.registros, &(&1.data.year == ano))
        end)
    end
  end
end
