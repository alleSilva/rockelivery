defmodule Rockelivery do
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Get, as: UserGet
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Update, as: UserUpdate

  alias Rockelivery.Items.Create, as: ItemCreate
  alias Rockelivery.Items.Get, as: ItemGet
  alias Rockelivery.Items.Delete, as: ItemDelete
  alias Rockelivery.Items.Update, as: ItemUpdate

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate get_user(id), to: UserGet, as: :by_id

  defdelegate delete_user(id), to: UserDelete, as: :call

  defdelegate update_user(params), to: UserUpdate, as: :call

  defdelegate create_item(params), to: ItemCreate, as: :call
  defdelegate get_item(id), to: ItemGet, as: :by_id

  defdelegate delete_item(id), to: ItemDelete, as: :call

  defdelegate update_item(params), to: ItemUpdate, as: :call
end
