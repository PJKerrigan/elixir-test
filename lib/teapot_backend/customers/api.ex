defmodule TeapotBackend.Customers.Api do
  alias TeapotBackend.Customers.Agents.CustomerId
  alias TeapotBackend.Customers.Commands.CreateCustomer

  def create(opts) do
    TeapotBackend.Cmd.dispatch(%CreateCustomer{id: CustomerId.next()})
  end
end
