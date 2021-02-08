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

  def imprimir_relatorio() do
  end
end
