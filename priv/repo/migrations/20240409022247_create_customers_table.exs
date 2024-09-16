defmodule TeapotBackend.Repo.Migrations.CreateCustomersTable do
  use Ecto.Migration

  def change do
    create table("customers", primary_key: false) do
      add :id, :integer, primary_key: true, null: false
      add :deleted_at, :utc_datetime_usec, default: nil
      add :created_at, :utc_datetime_usec
    end
  end
end