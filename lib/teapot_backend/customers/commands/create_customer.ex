defmodule TeapotBackend.Customers.Commands.CreateCustomer do
  use OnePiece.Commanded.Command, aggregate_identifier: {:id, :integer}

  @type t :: %__MODULE__{id: integer}
  @enforce_keys []

  embedded_schema do
  end
end
