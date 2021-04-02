defmodule Rockelivery.Users.Get do
  alias Ecto.UUID
  alias Rockelivery.Repo
  alias Rockelivery.Users.User

  def by_id(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, %{status: :bad_request, result: "invalid id format"}}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, %{status: :not_foud, result: "user not found"}}
      user -> {:ok, user}
    end
  end
end
