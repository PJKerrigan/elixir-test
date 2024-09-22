defmodule TeapotBackend.Customers.Projections.Customer do
  alias __MODULE__
  alias TeapotBackend.Repo
  import Ecto.Changeset
  import Ecto.Query
  use Ecto.Schema

  @primary_key {:id, :integer, autogenerate: false}
  @derive {Phoenix.Param, key: :id}

  schema "customers" do
    field :created_at, :utc_datetime_usec
    field :deleted_at, :utc_datetime_usec, default: nil
  end

  def changeset_insert(projection, attrs) do
    projection
    |> cast(attrs, [:id, :created_at])
    |> validate_required([:id, :created_at])
  end

  def changeset_delete(projection, attrs \\ %{}) do
    projection
    |> cast(attrs, [:deleted_at, :id])
    |> validate_required([:deleted_at, :id])
    |> unique_constraint(:id, name: :customers_pkey)
  end

  def exists?(id) do
    Repo.exists?(from x in Customer, where: x.id == ^id)
  end

  def get(id) do
    Repo.get(Customer, id)
  end

  def get!(id) do
    Repo.get!(Customer, id)
  end
end
