defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{} = result}), do: {:ok, result}

  defp handle_insert({:error, _result}) do
    {:error, Error.build(:bad_request, "Invalid Parameters")}
  end
end
