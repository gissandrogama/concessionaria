defmodule ConcessionariaTest do
  use ExUnit.Case
  doctest Concessionaria

  setup do
    File.write!("novo.txt", :erlang.term_to_binary([]))
    File.write!("semi.txt", :erlang.term_to_binary([]))

    on_exit(fn ->
      File.rm("novo.txt")
      File.rm("semi.txt")
    end)
  end

  test "cadastrar um veículo" do
    assert Concessionaria.cadastrar_carro(
             "2020",
             "Fiat",
             "argo",
             "automatico",
             "gasolina",
             "preta",
             4,
             "123456abc",
             :novo
           ) == {:ok, "Veículo com chassi 123456abc, cadastrado com sucesso!"}
  end

  test "comprar um veículo novo" do
    Concessionaria.cadastrar_carro(
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

    assert Concessionaria.comprar("123456abc", DateTime.utc_now(), 9000, :novo) ==
             {:ok, "Compra do veículo 123456abc cadastrada!"}
  end

  test "comprar um veículo seminovo" do
    Concessionaria.cadastrar_carro(
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

    assert Concessionaria.comprar("123456abc", DateTime.utc_now(), 9000, :seminovo) ==
             {:ok, "Compra do seminovo 123456abc cadastrada!"}
  end

  test "vender um veículo novo" do
    Concessionaria.cadastrar_carro(
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

    assert Concessionaria.vender("123456abc", DateTime.utc_now(), 45000, :novo) ==
             {:ok, "Venda do veículo 123456abc cadastrada!"}
  end

  test "vender um veículo seminovo" do
    Concessionaria.cadastrar_carro(
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

    assert Concessionaria.vender("123456abc", DateTime.utc_now(), 45000, :seminovo) ==
             {:ok, "Venda do seminovo 123456abc cadastrada!"}
  end

  test "imprimir relatório" do
    Concessionaria.cadastrar_carro(
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

    Concessionaria.cadastrar_carro(
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

    Concessionaria.comprar("123456abcd", DateTime.utc_now(), 15000, :novo)
    Concessionaria.comprar("123456abc", DateTime.utc_now(), 15000, :novo)
    Concessionaria.vender("123456abc", DateTime.utc_now(), 55000, :novo)

    data = DateTime.utc_now()

    assert Concessionaria.imprimir_relatorio(data.month, data.year) == :ok
  end

  test "start" do
    assert Concessionaria.start() == :ok
  end
end
