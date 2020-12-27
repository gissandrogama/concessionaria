defmodule Concessionaria do
  @moduledoc """
  Documentation for `Concessionaria`.
  """

  def start do
    File.write!("novo.txt", :erlang.term_to_binary([]))
    File.write!("semi.txt", :erlang.term_to_binary([]))
  end

  def cadastrar_carro(ano,  marca, modelo, cambio, combustivel, cor, portas, chassi, tipo) do
    Car.cadastrar(ano, marca, modelo, cambio, combustivel, cor, portas, chassi, tipo)
  end
end
