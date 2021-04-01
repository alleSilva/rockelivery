defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view
  alias Rockelivery.Users.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "user created!",
      name: user.name,
      id: user.id
    }
  end
end
