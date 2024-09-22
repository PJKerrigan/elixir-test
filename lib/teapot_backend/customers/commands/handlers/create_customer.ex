defmodule TeapotBackend.Customers.Commands.Handlers.CreateCustomer do
  @behaviour Commanded.Commands.Handler

  alias TeapotBackend.Customers.Aggregates.Customer, as: Aggregate
  alias TeapotBackend.Customers.Events.CustomerCreated, as: Event
  alias TeapotBackend.Customers.Commands.CreateCustomer, as: Command

  def handle(%Aggregate{id: nil}, %Command{id: id}) do
    {:ok, %Event{id: id, recorded_at: DateTime.utc_now(:microsecond)}}
  end

  def handle(%Aggregate{id: _id}, %Command{}) do
    {:error, :customer_exists}
  end
end
