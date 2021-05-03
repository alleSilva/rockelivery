defmodule Rockelivery.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias Rockelivery.Orders.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:address, :age, :cep, :cpf, :email, :password, :name]
  @derive {Jason.Encoder, only: [:id, :address, :age, :cep, :cpf, :email, :name]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    has_many :orders, Order

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    |> unique_constraint([:cpf])
    |> unique_constraint([:email])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
