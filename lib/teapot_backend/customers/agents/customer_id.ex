defmodule TeapotBackend.Customers.Agents.CustomerId do
  use Agent
  import Ecto.Query

  alias TeapotBackend.Repo
  alias TeapotBackend.Customers.Projections.Customer

  def start_link(_initial_value) do
    case from(c in Customer, select: max(c.id)) |> Repo.one() do
      nil -> Agent.start_link(fn -> 1 end, name: __MODULE__)
      count -> Agent.start_link(fn -> count + 1 end, name: __MODULE__)
    end
  end

  def current() do
    Agent.get(__MODULE__, & &1)
  end

  def next() do
    Agent.get_and_update(__MODULE__, fn id -> {id, id + 1} end)
  end
end
