defmodule Hochfuenf.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :avatar, :string
    field :email, :string
    field :provider, :string
    field :external_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :avatar, :email, :provider, :external_id])
    |> validate_required([:name, :avatar, :email, :provider, :external_id])
  end
end
