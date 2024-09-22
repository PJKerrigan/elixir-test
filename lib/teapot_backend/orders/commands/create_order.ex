defmodule TeapotBackend.Customers.Commands.CreateCustomer do
  use OnePiece.Commanded.Command, aggregate_identifier: {:id, :binary_id}

  @type t :: %__MODULE__{id: integer}
  @enforce_keys []

  embedded_schema do

  end
end
