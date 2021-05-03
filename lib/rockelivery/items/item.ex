defmodule Rockelivery.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Enum
  alias Rockelivery.Orders.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:category, :description, :photo, :price]
  @categories [:desert, :drink, :food]
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :category, Enum, values: @categories
    field :description, :string
    field :photo, :string
    field :price, :decimal

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 3)
    |> validate_number(:price, greater_than: 0)
  end
end
