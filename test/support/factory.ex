defmodule Rockelivery.Factory do
  use ExMachina

  def user_params_factory do
    %{
      address: "Rua Leao de Juda",
      age: 34,
      cep: "69042833",
      cpf: "88250555287",
      email: "silva_alesandro@outlook.com",
      password: "123456",
      name: "Alesandro Silva"
    }
  end
end
