defmodule CaixaTest do
  use ExUnit.Case

  test "Retornar a estrutura do caixa" do
    assert %Caixa{} == %Caixa{data: nil, valor: nil}
  end
end
