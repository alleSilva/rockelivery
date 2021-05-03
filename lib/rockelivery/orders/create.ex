defmodule Rockelivery.Orders.Create do
  import Ecto.Query
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.Items.Item

  def call(params) do
    params
    |> fetch_items()
  end

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    Repo.all(query)
  end
end
