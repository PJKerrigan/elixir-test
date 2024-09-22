defmodule TeapotBackend.Customers.Api do
  alias TeapotBackend.Customers.Agents.CustomerId
  alias TeapotBackend.Customers.Commands.{CreateCustomer, DeleteCustomer}
  alias TeapotBackend.Customers.Projections.Customer, as: Projection
  alias TeapotBackend.Customers.Aggregates.Customer, as: Aggregate

  def create() do
    TeapotBackend.Cmd.dispatch(%CreateCustomer{id: CustomerId.next()})
  end

  def delete(id, reason) do
    TeapotBackend.Cmd.dispatch(%DeleteCustomer{id: id, reason: reason})
  end

  def get_projection(id) do
    Projection.get(id)
  end

  def get_aggregate(id) do
    TeapotBackend.Cmd.aggregate_state(Aggregate, id)
  end
end
