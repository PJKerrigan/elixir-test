defmodule TeapotBackend.Customers.Aggregates.Customer do
  @moduledoc "Customer aggregate root. Root entity for all others."

  alias __MODULE__
  alias TeapotBackend.Customers.Events.{CustomerCreated, CustomerDeleted}

  defstruct [:id, :created_at, :deleted_at, :deleted_reason]

  def apply(%Customer{} = aggregate, %CustomerCreated{id: id, recorded_at: recorded_at}) do
    %Customer{aggregate |
      id: id,
      created_at: recorded_at
    }
  end

  def apply(%Customer{} = aggregate, %CustomerDeleted{recorded_at: recorded_at, reason: reason}) do
    %Customer{aggregate |
      deleted_at: recorded_at,
      deleted_reason: reason
    }
  end
end
