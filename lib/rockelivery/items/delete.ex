defmodule Rockelivery.Items.Delete do
  alias Ecto.UUID
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.Items.Item

  def call(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, Error.build(:bad_request, "invalid id format")}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case Repo.get(Item, uuid) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      item -> Repo.delete(item)
    end
  end
end
