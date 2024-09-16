defmodule TeapotBackend.Customers.Commands.Handlers.DeleteCustomer do
  @behaviour Commanded.Commands.Handler

  alias TeapotBackend.Customers.Aggregates.Customer, as: Aggregate
  alias TeapotBackend.Customers.Events.CustomerDeleted, as: Event
  alias TeapotBackend.Customers.Commands.DeleteCustomer, as: Command

  def handle(%Aggregate{id: nil}, %Command{}) do
    {:error, :customer_does_not_exist}
  end
  
  def handle(%Aggregate{id: _id}, %Command{id: id, reason: reason}) do
    {:ok, %Event{id: id, recorded_at: DateTime.utc_now(:microsecond), reason: reason}}
  end
end
