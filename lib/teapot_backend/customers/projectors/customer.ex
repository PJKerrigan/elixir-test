defmodule TeapotBackend.Customers.Projectors.Customer do
  use Commanded.Projections.Ecto,
    application: TeapotBackend.Cmd,
    consistency: :strong,
    name: __MODULE__,
    repo: TeapotBackend.Repo

  alias TeapotBackend.Customers.Events.{CustomerCreated, CustomerDeleted}
  alias TeapotBackend.Customers.Projections.Customer, as: Projection

  project(%CustomerCreated{id: id, recorded_at: recorded_at} = _event, _, fn multi ->
    Ecto.Multi.insert(multi, {:customer, id}, Projection.changeset_insert(%Projection{}, %{
      id: id,
      created_at: DateTime.from_iso8601(recorded_at) |> elem(1)
    }))
  end)

  project(%CustomerDeleted{id: id, recorded_at: recorded_at} = _event, _, fn multi ->
    case Projection.get(id) do
      nil -> multi
      projection ->
        Ecto.Multi.update(multi, {:customer, id}, Projection.changeset_delete(projection, %{
          id: id,
          deleted_at: DateTime.from_iso8601(recorded_at) |> elem(1)
        }))
    end
  end)
end
