defmodule Hochfuenf.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :avatar, :string
      add :email, :string

      add :external_id, :string
      add :provider, :string

      timestamps(type: :utc_datetime)
    end
  end
end
