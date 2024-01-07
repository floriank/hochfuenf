defmodule Hochfuenf.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hochfuenf.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        avatar: "some avatar",
        name: "some name"
      })
      |> Hochfuenf.Accounts.create_user()

    user
  end
end
