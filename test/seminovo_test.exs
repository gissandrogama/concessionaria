defmodule SeminovoTest do
  use ExUnit.Case
  doctest Seminovo

  setup do
    File.write!("novo.txt", :erlang.term_to_binary([]))
    File.write!("semi.txt", :erlang.term_to_binary([]))

    on_exit(fn ->
      File.rm("novo.txt")
      File.rm("semi.txt")
    end)
  end

  describe "Funções para comprar e vender" do
    test "cadastro de compra um veículo seminovo" do
      Car.cadastrar(
        "2020",
        "Fiat",
        "argo",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abc",
        :seminovo
      )

      assert Seminovo.compra("123456abc", DateTime.utc_now(), 30000) ==
               {:ok, "Compra do seminovo 123456abc cadastrada!"}

      carro = Car.buscar_carro("123456abc", :seminovo)
      registro = carro.registros
      assert Enum.count(registro) == 1
    end

    test "cadastro de venda de um veículo seminovo" do
      Car.cadastrar(
        "2020",
        "Fiat",
        "argo",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abc",
        :seminovo
      )

      Seminovo.compra("123456abc", DateTime.utc_now(), 30000)

      assert Seminovo.venda("123456abc", DateTime.utc_now(), 50000) ==
               {:ok, "Venda do seminovo 123456abc cadastrada!"}

      carro = Car.buscar_carro("123456abc", :seminovo)
      registro = carro.registros
      assert Enum.count(registro) == 2
    end
  end

  describe "testa para impressão de relatório" do
    test "relatório de compra de carros novos filtro mês e ano" do
      Car.cadastrar(
        "2021",
        "Fiat",
        "argo",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abc",
        :seminovo
      )

      Car.cadastrar(
        "2021",
        "Fiat",
        "palio",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abcd",
        :seminovo
      )

      data_antiga = ~U[2021-01-04 23:16:24.136051Z]
      data = DateTime.utc_now()

      Seminovo.compra("123456abc", data_antiga, 8000)
      Seminovo.compra("123456abcd", data, 8000)

      carro = Car.carros_seminovo()

      assert Enum.map(carro, &(&1.registros)) |> Enum.count() == 2

      relatorio = Seminovo.relatorio(data.month, data.year)

      assert Enum.count(relatorio) == 1
    end
  end
end
