defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller
  alias RockeliveryWeb.FallbackController
  alias Rockelivery.Users.User
  
  action_fallback FallbackController
  def create(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
