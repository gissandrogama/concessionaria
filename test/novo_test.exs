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

      assert Novo.venda("123456abc", DateTime.utc_now(), 50000) ==
               {:ok, "Venda do veículo 123456abc cadastrada!"}
    end
  end
end
