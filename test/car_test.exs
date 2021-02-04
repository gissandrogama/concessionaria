defmodule CarTest do
  use ExUnit.Case
  doctest Car

  setup do
    File.write!("novo.txt", :erlang.term_to_binary([]))
    File.write!("semi.txt", :erlang.term_to_binary([]))

    on_exit(fn ->
      File.rm("novo.txt")
      File.rm("semi.txt")
    end)
  end

  describe "Testes responsaveis por cadastro de veículos" do
    test "Retornar a estrutura de veículo" do
      assert %Car{ano: "", marca: "", modelo: "", chassi: ""} = %Car{
               ano: "",
               cambio: nil,
               chassi: "",
               combustivel: nil,
               cor: nil,
               marca: "",
               modelo: "",
               portas: nil,
               tipo: nil
             }
    end

    test "criar um veículo" do
      assert Car.cadastrar(
               "2020",
               "Fiat",
               "argo",
               "automatico",
               "gasolina",
               "preta",
               4,
               "123456abc",
               :novo
             ) ==
               {:ok, "Veículo com chassi 123456abc, cadastrado com sucesso!"}
    end

    test "deve retorna erro dizendo que veículo ja esta cadastrado" do
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

      assert Car.cadastrar(
               "2020",
               "Fiat",
               "argo",
               "automatico",
               "gasolina",
               "preta",
               4,
               "123456abc",
               :novo
             ) ==
               {:error, "Veículo já cadastrado"}
    end
  end

  describe "Testes responsveis por bucar veículo" do
    test "buscar veículo novo" do
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

      assert Car.buscar_carro("123456abc", :novo).modelo == "argo"
      assert Car.buscar_carro("123456abc", :novo).tipo.__struct__ == Novo
    end

    test "buscar seminovo" do
      Car.cadastrar(
        "2020",
        "Fiat",
        "palio",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abcd",
        :seminovo
      )

      assert Car.buscar_carro("123456abcd", :seminovo).modelo == "palio"
    end
  end

  describe "deletar" do
    test "deve deletar um veículo" do
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

      Car.cadastrar(
        "2020",
        "Fiat",
        "palio",
        "automatico",
        "gasolina",
        "preta",
        4,
        "123456abcd",
        :seminovo
      )

      assert Car.deletar("123456abc") == {:ok, "Veículo com o chassi: 123456abc deletado!"}
    end
  end
end
