defmodule Rockelivery.Users.Delete do
  alias Ecto.UUID
  alias Rockelivery.Repo
  alias Rockelivery.Users.User

  def call(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, %{status: :bad_request, result: "invalid id format"}}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, %{status: :not_found, result: "user not found"}}
      user -> Repo.delete(user)
    end
  end
end
