defmodule Hochfuenf.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :avatar, :string
      add :email, :string, null: false

      add :external_id, :string, null: false
      add :provider, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
