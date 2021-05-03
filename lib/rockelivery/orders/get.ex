defmodule Rockelivery.Orders.Get do
  alias Ecto.UUID
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.Items.Item

  def by_id(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, Error.build(:bad_request, "Invalid id format!")}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Item, uuid) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      user -> {:ok, user}
    end
  end
end
