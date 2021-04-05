defmodule Rockelivery.Users.Update do
  alias Ecto.UUID
  alias Rockelivery.Repo
  alias Rockelivery.Users.User

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "invalid id format"}}
      {:ok, _id} -> update(params)
    end
  end

  defp update(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "user not found"}}
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
