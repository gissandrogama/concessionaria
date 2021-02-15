defmodule Concessionaria do
  @moduledoc """
  Documentation for `Concessionaria`.
  """

  def start do
    File.write!("novo.txt", :erlang.term_to_binary([]))
    File.write!("semi.txt", :erlang.term_to_binary([]))
  end

  def cadastrar_carro(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, tipo) do
    Car.cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, tipo)
  end

  def comprar(chassi, data, valor, tipo) do
    case tipo do
      :novo ->
        Novo.compra(chassi, data, valor)

      :seminovo ->
        Seminovo.compra(chassi, data, valor)
    end
  end

  def vender(chassi, data, valor, tipo) do
    case tipo do
      :novo ->
        Novo.venda(chassi, data, valor)

      :seminovo ->
        Seminovo.venda(chassi, data, valor)
    end
  end

  def imprimir_relatorio(mes, ano) do
    {comprados, vendidos} = Novo.relatorio(mes, ano)
    valor_compra = process_valor_compra(comprados)
    valor_venda = process_valor_venda(vendidos)

    IO.puts("*************************************************************")
    IO.puts("Relatório de comparas de veículos novos")
    IO.puts("*************************************************************")

    comprados
    |> Enum.each(fn veiculo ->
      IO.puts("Maca do veículo: #{veiculo.marca}")
      IO.puts("Modelo do veículo: #{veiculo.modelo}")
      IO.puts("Chassi do veículo: #{veiculo.chassi}")
      IO.puts("Data da compra: #{List.first(veiculo.registros).data}")
      IO.puts("Valor da compra: #{List.first(veiculo.registros).valor}")
      IO.puts("------------------------------------------------------------")
    end)
    IO.puts("Valor total de compras: #{Enum.sum(valor_compra)}")
    IO.puts("**************************Fim relatório compras**********************************")

    IO.puts("*************************************************************")
    IO.puts("Relatório de vendas de veículos novos")
    IO.puts("*************************************************************")

    vendidos
    |> Enum.each(fn veiculo ->
      IO.puts("Maca do veículo: #{veiculo.marca}")
      IO.puts("Modelo do veículo: #{veiculo.modelo}")
      IO.puts("Chassi do veículo: #{veiculo.chassi}")
      IO.puts("Data da compra: #{List.first(veiculo.registros).data}")
      IO.puts("Valor da compra: #{List.first(veiculo.registros).valor}")
      IO.puts("------------------------------------------------------------")
    end)
    IO.puts("Valor total de compras: #{Enum.sum(valor_venda)}")
    IO.puts("**************************Fim relatório vendas**********************************")
  end

  defp process_valor_compra(relatorio) do
    relatorio
    |> Enum.map(fn veiculo ->
      case Enum.count(veiculo.registros) do
        2 -> List.first(veiculo.registros)
        1 -> List.first(veiculo.registros)
      end
    end)
    |> Enum.map(& &1.valor)
  end

  defp process_valor_venda(relatorio) do
    relatorio
    |> Enum.map(fn veiculo ->
      case Enum.count(veiculo.registros) do
        2 -> List.last(veiculo.registros)
      end
    end)
    |> Enum.map(& &1.valor)
  end
end
