defmodule Rockelivery.Orders.Create do
  import Ecto.Query
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.Items.Item
  alias Rockelivery.Orders.Order

  def call(params) do
    params
    |> fetch_items()
    |> handle_fetch(params)
  end

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> validate_and_multply_items(items_ids, items_params)
  end

  defp validate_and_multply_items(items, items_ids, items_params) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    items_ids
    |> Enum.map(fn id -> {id, Map.get(items_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(items_map, items_params)
  end

  defp multiply_items(true, _items, _items_params), do: {:error, "Invalid Ids"}

  defp multiply_items(false, items, items_params) do
    items =
      Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        item = Map.get(items, id)
        acc ++ List.duplicate(item, quantity)
      end)

    {:ok, items}
  end

  defp handle_fetch({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_fetch({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = order), do: order
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
