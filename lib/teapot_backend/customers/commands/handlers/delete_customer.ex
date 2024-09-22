defmodule TeapotBackend.Customers.Commands.Handlers.CreateCustomer do
  @behaviour Commanded.Commands.Handler

  alias TeapotBackend.Customers.Aggregates.Customer, as: Aggregate
  alias TeapotBackend.Customers.Events.CustomerDeleted, as: Event
  alias TeapotBackend.Customers.Commands.DeleteCustomer, as: Command

  def handle(%Aggregate{id: nil}, %Command{id: id}) do
    {:error, :customer_does_not_exist}
  end

  def handle(%Aggregate{id: _id, deleted_at: deleted_at}) do
    {:error, :customer_is_deleted}
  end

  def handle(%Aggregate{id: id, deleted_at: nil}, %Command{reason: reason}) do
    {:ok, %Event{
      id: id,
      reason: reason,
      recorded_at: DateTime.utc_now(:microsecond)
    }}
  end
end
