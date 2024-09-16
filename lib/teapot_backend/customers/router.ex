defmodule TeapotBackend.Customers.Router do
  use Commanded.Commands.Router

  alias TeapotBackend.Customers.Aggregates.Customer, as: Aggregate
  alias TeapotBackend.Customers.Commands.{CreateCustomer, DeleteCustomer}
  alias TeapotBackend.Customers.Commands.Handlers.CreateCustomer, as: CreateCustomerHandler
  alias TeapotBackend.Customers.Commands.Handlers.DeleteCustomer, as: DeleteCustomerHandler

  dispatch([CreateCustomer], to: CreateCustomerHandler, aggregate: Aggregate, identity: :id)
  dispatch([DeleteCustomer], to: DeleteCustomerHandler, aggregate: Aggregate, identity: :id)
end
