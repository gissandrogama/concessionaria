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

    test "criar uma conta prepago" do
      assert Car.cadastrar(
               "2020",
               "Fiat",
               "argo",
               "automatico",
               "gasolina",
               "preta",
               4,
               "123456abc"
             ) ==
               {:ok, "Veículo com chassi 123456abc, cadastrado com sucesso!"}
    end

    test "deve retorna erro dizendo que veículo ja esta cadastrado" do
      Car.cadastrar("2020", "Fiat", "argo", "automatico", "gasolina", "preta", 4, "123456abc")

      assert Car.cadastrar(
               "2020",
               "Fiat",
               "argo",
               "automatico",
               "gasolina",
               "preta",
               4,
               "123456abc"
             ) ==
               {:error, "Veículo já cadastrado"}
    end
  end
end
