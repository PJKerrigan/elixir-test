defmodule TeapotBackend.Customers.Supervisors.CustomerId do
  alias TeapotBackend.Customers.Projections.Customer
  use Supervisor
  import Ecto.Query

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        TeapotBackend.Customers.Agents.CustomerId
      ],
      strategy: :one_for_one
    )
  end
end
