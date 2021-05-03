defmodule Rockelivery.Items.Update do
  alias Ecto.UUID
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.Items.Item

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, Error.build(:bad_request, "invalid id format")}
      {:ok, _id} -> update(params)
    end
  end

  defp update(%{"id" => id} = params) do
    case Repo.get(Item, id) do
      nil -> {:error, Error.build(:not_found, "user not found")}
      item -> do_update(item, params)
    end
  end

  defp do_update(item, params) do
    item
    |> Item.changeset(params)
    |> Repo.update()
  end
end
