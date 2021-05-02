defmodule Rockelivery.Users.Delete do
  alias Ecto.UUID
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.Users.User

  def call(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, Error.build(:bad_request, "invalid id format")}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      user -> Repo.delete(user)
    end
  end
end
