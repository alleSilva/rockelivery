defmodule Rockelivery.Users.UserTest do
  use Rockelivery.DataCase, async: true
  import Rockelivery.Factory
  alias Ecto.Changeset
  alias Rockelivery.Users.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      user_params = build(:user_params)

      response = User.changeset(user_params)

      assert %Changeset{changes: %{name: "Alesandro Silva"}, valid?: true} = response
    end

    test "when update a changeset, returns a valid changeset with changes" do
      user_params = build(:user_params)

      changeset = User.changeset(user_params)
      update_user_params = %{name: "Biro Liro", password: "123456"}
      response = change(changeset, update_user_params)

      assert %Changeset{changes: %{name: "Biro Liro", password: "123456"}, valid?: true} =
               response
    end

    test "when there are some errors, returns a invalid changeset" do
      user_params = build(:user_params, %{age: 15, password: "123"})

      response = User.changeset(user_params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
