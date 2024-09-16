defmodule TeapotBackend.Customers.Commands.DeleteCustomer do
  use OnePiece.Commanded.Command, aggregate_identifier: :id

  @enforce_keys []
  @type t :: %__MODULE__{id: binary, reason: binary}

  embedded_schema do
    field :reason
  end
end
