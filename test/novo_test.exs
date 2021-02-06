defmodule NovoTest do
  use ExUnit.Case
  doctest Novo

  setup do
    File.write!("novo.txt", :erlang.term_to_binary([]))
    File.write!("semi.txt", :erlang.term_to_binary([]))

    on_exit(fn ->
      File.rm("novo.txt")
      File.rm("semi.txt")
    end)
  end

  describe "Funções para comprar e vender" do
    test "cadastro de compra um veículo novo" do
      Car.cadastrar(
        "2020",
        "Fiat",
        "argo",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abc",
        :novo
      )

      assert Novo.compra("123456abc", DateTime.utc_now(), 30000) ==
               {:ok, "Compra do veículo 123456abc cadastrada!"}

      carro = Car.buscar_carro("123456abc", :novo)
      registro = carro.registros
      assert Enum.count(registro) == 1
    end

    test "cadastro de venda de um veículo novo" do
      Car.cadastrar(
        "2020",
        "Fiat",
        "argo",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abc",
        :novo
      )

      Novo.compra("123456abc", DateTime.utc_now(), 30000)

      assert Novo.venda("123456abc", DateTime.utc_now(), 50000) ==
               {:ok, "Venda do veículo 123456abc cadastrada!"}

      carro = Car.buscar_carro("123456abc", :novo)
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
        :novo
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
        :novo
      )

      data_antiga = ~U[2021-01-04 23:16:24.136051Z]
      data = DateTime.utc_now()

      Novo.compra("123456abc", data_antiga, 15000)
      Novo.compra("123456abcd", data, 15000)

      carro = Car.carros_novo()

      assert Enum.map(carro, &(&1.registros)) |> Enum.count() == 2

      relatorio = Novo.relatorio(data.month, data.year)

      assert Enum.count(relatorio) == 1
    end
  end
end
